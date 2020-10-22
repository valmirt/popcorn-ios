//
//  DetailTVShowViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 07/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

protocol DetailTVShowPresenter {
    //TODO
}

typealias DetailTVShowPresenterCoordinator = DetailTVShowPresenter & Coordinator

final class DetailTVShowViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailTVShowViewModel?
    var coordinator: DetailTVShowPresenterCoordinator?
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbInProduction: UILabel!
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var lbNumberSeason: UILabel!
    @IBOutlet weak var lbNumberEpisodes: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var cvCreators: UICollectionView!
    @IBOutlet weak var tvSeasons: UITableView!
    @IBOutlet weak var containerLoading: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        viewModel?.delegate = self
        viewModel?.loadData()
        performLoading(status: true)
    }
    
    private func errorAlert(message: String?) {
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    private func fillData() {
        lbTitle.text = viewModel?.title
        lbGenres.text = viewModel?.genres
        lbCountry.text = viewModel?.countries
        lbInProduction.text = viewModel?.inProduction
        lbRuntime.text = viewModel?.runtime
        lbNumberSeason.text = viewModel?.numberSeasons
        lbNumberEpisodes.text = viewModel?.numberEpisodes
        viewModel?.getImage(onComplete: { (image) in
            self.ivPoster.image = image
        })
    }
    
    private func performLoading(status: Bool) {
        if status {
            containerLoading.isHidden = false
            loadingSpinner.startAnimating()
        } else {
            containerLoading.isHidden = true
            loadingSpinner.stopAnimating()
        }
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("DetailTVShowViewController free")
    }
}

// MARK: - Collection view datasource
extension DetailTVShowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.creatorsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvCreators.dequeueReusableCell(withReuseIdentifier: "creatorCell", for: indexPath) as! CreditCollectionViewCell
        cell.configure(with: viewModel?.getCreditViewModel(at: indexPath))
        return cell
    }
}

// MARK: - Table view datasource
extension DetailTVShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.seasonsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvSeasons.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as! SeasonTableViewCell
        cell.configure(with: viewModel?.getSeasonViewModel(at: indexPath))
        return cell
    }
}

//MARK: - Detail TV Show viewModel delgate
extension DetailTVShowViewController: DetailTVShowViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: errorMessage)
            self.performLoading(status: false)
        }
    }
    
    func onListenerTVShowDetail() {
        DispatchQueue.main.async {
            self.fillData()
            self.cvCreators.reloadData()
            self.tvSeasons.reloadData()
            self.performLoading(status: false)
        }
    }
}

