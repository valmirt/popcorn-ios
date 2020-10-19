//
//  DetailTVViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 07/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class DetailTVViewController: UIViewController {
    
    // MARK: - Properties
    var id = 0
    var viewModel: DetailTVShowViewModel?
    private lazy var tvRepository: TVShowRepositoryProtocol = TVShowRepository()
    private var tvShow: TVShowDetail?
    
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
        
        setupRepository()
    }
    
    // MARK: - Methods
    private func setupRepository() {
        tvRepository.delegate = self
        
        tvRepository.detailTVShow(with: id)
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
    
    private func fillData(with tv: TVShowDetail) {
        tvShow = tv
        lbTitle.text = tvShow?.name
        lbGenres.text = tvShow?.genresFormatted
        lbCountry.text = tvShow?.countriesFormatted
        lbInProduction.text = "In Production: \(tvShow?.inProduction ?? false ? "Yes" : "No")"
        lbRuntime.text = "Runtime: \(tvShow?.runTimeFormatted ?? "~") min"
        lbNumberSeason.text = "Seasons: \(tvShow?.numberOfSeasons ?? 0)"
        lbNumberEpisodes.text = "Episodes: \(tvShow?.numberOfEpisodes ?? 0)"
        if let tvShow = tvShow, let poster = tvShow.posterPath {
            setImage(with: poster)
        }
    }
    
    private func setImage(with poster: String) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(poster)"
        tvRepository.updateImage(baseURL: base, path: path) { image in
            self.ivPoster.image = image
        }
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
}

// MARK: - Collection view datasource
extension DetailTVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tv = tvShow {
            return tv.createdBy?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvCreators.dequeueReusableCell(withReuseIdentifier: "creatorCell", for: indexPath) as! CreditCollectionViewCell
        
        if let tv = tvShow, let creator = tv.createdBy?[indexPath.item] {
//            cell.fillCell(with: creator)
        }
        
        return cell
    }
}

// MARK: - Table view datasource
extension DetailTVViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tv = tvShow {
            return tv.seasons?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvSeasons.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as! SeasonTableViewCell
        
        if let tv = tvShow, let season = tv.seasons?[indexPath.row] {
            cell.fillCell(with: season)
        }
        
        return cell
    }
}

// MARK: - TV show delegate
extension DetailTVViewController: TVShowRepositoryDelegate {
    func tvShowRepository(_ manager: TVShowRepository, didUpdateError: Error) {
        DispatchQueue.main.async {
            self.errorAlert(message: didUpdateError.localizedDescription)
            self.performLoading(status: false)
        }
    }
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateTVShowDetail: TVShowDetail) {
        DispatchQueue.main.async {
            self.fillData(with: didUpdateTVShowDetail)
            self.cvCreators.reloadData()
            self.tvSeasons.reloadData()
            self.performLoading(status: false)
        }
    }
}

