//
//  PeopleViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol PeoplePresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?)
    func showDetailTVShow(with viewModel: DetailTVShowViewModel?)
    func exitThisScreen()
}

typealias PeoplePresenterCoordinator = PeoplePresenter & Coordinator

final class PeopleViewController: UIViewController, HasCodeView {
    typealias CustomView = PeopleView
    
    // MARK: - Properties
    var coordinator: PeoplePresenterCoordinator?
    var viewModel: PeopleViewModel?
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    // MARK: - Methods
    private func showError(with message: String) {
        let alert = ErrorAlertUtil.errorAlert(message: message) { self.coordinator?.exitThisScreen() }
        present(alert, animated: true, completion: nil)
    }
    
    private func setupView() {
        title = "Person"
        view = PeopleView()
        customView?.filmographyCollectionView.delegate = self
        customView?.filmographyCollectionView.dataSource = self
        viewModel?.delegate = self
        
        
        viewModel?.loadData()
        performLoading(status: true)
    }
    
    private func fillData() {
        customView?.nameLabel.text = viewModel?.name
        customView?.birthdayLabel.text = viewModel?.birthday
        customView?.deathdayLabel.text = viewModel?.deathday
        customView?.departmentLabel.text = viewModel?.department
        customView?.placeBirthLabel.text = viewModel?.placeOfBirth
        customView?.biographyTextView.text = viewModel?.biography
        customView?.popularityLabel.text = viewModel?.popularity
        viewModel?.getImage(onComplete: { image in
            self.customView?.imageProfile.image = image ?? UIImage(systemName: "person.fill")
        })
    }
    
    private func fillFilmography() {
        customView?.filmographyCollectionView.reloadData()
    }
    
    private func performLoading(status: Bool) {
        if status {
            customView?.loadingView.isHidden = false
            customView?.loadingView.loadingSpinner.startAnimating()
        } else {
            customView?.loadingView.isHidden = true
            customView?.loadingView.loadingSpinner.stopAnimating()
        }
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("PeopleViewController free")
    }
}

//MARK: - Collection view delegate and datasource
extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.countFilmography ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView?.filmographyCollectionView.dequeueReusableCell(withReuseIdentifier: PeopleView.cellIdentifier, for: indexPath) as! FilmographyCollectionViewCell
        
        cell.configure(with: viewModel?.getFilmographyViewModel(at: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel?.isCreditedMovie(at: indexPath) ?? true {
            coordinator?.showDetailMovie(with: viewModel?.getDetailMovieViewModel(at: indexPath))
        } else {
            coordinator?.showDetailTVShow(with: viewModel?.getDetailTVShowViewModel(at: indexPath))
        }
    }
}


//MARK: - ViewModel Delegate
extension PeopleViewController: PeopleViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.showError(with: errorMessage)
        }
    }
    
    func onListenerPeople() {
        DispatchQueue.main.async {
            self.fillData()
            self.performLoading(status: false)
        }
    }
    
    func onListenerFilmography() {
        DispatchQueue.main.async {
            self.fillFilmography()
            self.performLoading(status: false)
        }
    }
}
