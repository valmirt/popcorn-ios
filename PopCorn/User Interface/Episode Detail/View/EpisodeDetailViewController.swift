//
//  EpisodeDetailViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol EpisodeDetailPresenter {
    func showDetailPeople(with viewModel: PeopleViewModel?)
    func exitThisScreen()
}

typealias EpisodePresenterCoordinator = EpisodeDetailPresenter & Coordinator

final class EpisodeDetailViewController: UIViewController, HasCodeView {
    typealias CustomView = EpisodeDetailView
    
    // MARK: - Properties
    var coordinator: EpisodePresenterCoordinator?
    var viewModel: EpisodeDetailViewModel?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fillData()
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("EpisodeDetailViewController free")
    }
    
    // MARK: - Methods
    private func setupView() {
        view = EpisodeDetailView()
        viewModel?.delegate = self
        viewModel?.loadData()
        performLoading(status: true)
    }
    
    private func fillData() {
        customView?.creditCollectionView.delegate = self
        customView?.creditCollectionView.dataSource = self
        customView?.titleLabel.text = viewModel?.title
        customView?.airDateLabel.text = viewModel?.airDate
        customView?.seasonNumberLabel.text = viewModel?.seasonNumber
        customView?.episodeNumberLabel.text = viewModel?.episodeNumber
        customView?.overviewTextView.text = viewModel?.overview
        viewModel?.getImage(onComplete: { image in
            self.customView?.backdropImage.image = image ?? UIImage(systemName: "photo")
        })
    }
    
    private func creditListReload() {
        customView?.creditCollectionView.reloadData()
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
    
    private func showError(with message: String) {
        let alert = ErrorAlertUtil.errorAlert(message: message) { self.coordinator?.exitThisScreen() }
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - CollectionView datasouce and delegate
extension EpisodeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.creditCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView?.creditCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailView.cellIdentifier, for: indexPath) as! CrewAndGuestCollectionViewCell
        cell.configure(with: viewModel?.getCreditCellViewModel(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showDetailPeople(with: viewModel?.getPeopleViewModel(at: indexPath))
    }
}

//MARK: - EpisodeDetail delegate
extension EpisodeDetailViewController: EpisodeDetailViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.showError(with: errorMessage)
        }
    }
    
    func onListenerCredit() {
        DispatchQueue.main.async {
            self.creditListReload()
            self.performLoading(status: false)
        }
    }
    
}

