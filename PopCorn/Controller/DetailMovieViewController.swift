//
//  DetailMovieViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 07/11/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    
    // MARK: - Properties
    var id = 0
    private lazy var movieRepo: MovieRepository = ProdMovieRepository()
    private var credit: Credit?
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelCountries: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    @IBOutlet weak var labelCompanies: UILabel!
    @IBOutlet weak var tvOverview: UITextView!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var cvCastingAndCrew: UICollectionView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRepository()
    }
    
    // MARK: - Methods
    private func setupRepository() {
        movieRepo.delegate = self
        
        movieRepo.detailMovie(with: id)
        movieRepo.creditMovie(with: id)
        performLoading(status: true)
    }
    
    private func setImage(with poster: String) {
        let base = Constants.Web.BASE_URL_IMAGE
        let path = "\(Constants.Web.IMAGE_W342)\(poster)"
        movieRepo.updateImage(baseURL: base, path: path) { image in
            self.ivPoster.image = image
        }
    }
    
    private func fillData(with movie: MovieDetail) {
        DispatchQueue.main.async {
            self.labelTitle.text = movie.title
            self.labelGenres.text = movie.genresFormatted
            self.labelCountries.text = movie.countriesFormatted
            self.labelStatus.text = movie.status
            self.labelReleaseDate.text = movie.yearDate
            self.labelRuntime.text = "\(String(movie.runtime ?? 0)) min"
            self.labelCompanies.text = String(movie.revenue)
            self.tvOverview.text = movie.overview
            self.labelCompanies.text = movie.companiesFormatted
            if let poster = movie.posterPath {
                self.setImage(with: poster)
            }
        }
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
    
    private func performLoading(status: Bool) {
        if status {
            viewLoading.isHidden = false
            loadingSpinner.startAnimating()
        } else {
            viewLoading.isHidden = true
            loadingSpinner.stopAnimating()
        }
    }
    
    // MARK: - IBActions
    
}

extension DetailMovieViewController: MovieManagerDelegate {
    func movieManager(_ manager: MovieRepository, didUpdateError: Error) {
        DispatchQueue.main.async {
            self.errorAlert(message: didUpdateError.localizedDescription)
        }
    }
    
    func movieManager(_ manager: MovieRepository, didUpdateMovieDetail: MovieDetail) {
        DispatchQueue.main.async {
            self.fillData(with: didUpdateMovieDetail)
            self.performLoading(status: false)
        }
    }
    
    func movieManager(_ managet: MovieRepository, didUpdateCreditMovie: Credit) {
        DispatchQueue.main.async {
            self.credit = didUpdateCreditMovie
            self.cvCastingAndCrew.reloadData()
            self.performLoading(status: false)
        }
    }
}

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let credit = credit {
            return credit.cast.count + credit.crew.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvCastingAndCrew.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CreditCollectionViewCell
        
        if let credit = credit {
            if indexPath.row < credit.cast.count {
                cell.fillCell(with: credit.cast[indexPath.row])
            } else {
                let index = indexPath.row - credit.cast.count
                cell.fillCell(with: credit.crew[index])
            }
        }
        
        return cell
    }
}


