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
    private var page = Constants.General.FIRST
    private lazy var movieRepo: MovieRepository = ProdMovieRepository()
    private var credit: Credit?
    private var similarMovies: [Movie] = []
    
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
    @IBOutlet weak var cvSimilarMovies: UICollectionView!
    
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
        movieRepo.updateSimilarMovies(with: id, page)
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

//MARK: - Movie Manager delegate
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
    
    func movieManager(_ manager: MovieRepository, didUpdateSimilarMovies: [Movie], totalPages: Int) {
        if page < totalPages {
            similarMovies.append(contentsOf: didUpdateSimilarMovies)
            DispatchQueue.main.async {
                self.cvSimilarMovies.reloadData()
                self.performLoading(status: false)
            }
        }
    }
}

//MARK: - Collection view
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvCastingAndCrew {
            if let credit = credit {
                return credit.cast.count + credit.crew.count
            }
            return 0
        } else {
            return similarMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cvCastingAndCrew {
            return defineCreditCell(for: indexPath)
        } else {
            return defineSimilarMoviesCell(for: indexPath)
        }
    }
    
    private func defineCreditCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvCastingAndCrew.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CreditCollectionViewCell
        
        if let credit = credit {
            if indexPath.item < credit.cast.count {
                cell.fillCell(with: credit.cast[indexPath.item])
            } else {
                let index = indexPath.item - credit.cast.count
                cell.fillCell(with: credit.crew[index])
            }
        }
        
        return cell
    }
    
    private func defineSimilarMoviesCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSimilarMovies.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! SimilarMovieCollectionViewCell
        
        let movie = similarMovies[indexPath.item]
        cell.fillCell(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvSimilarMovies {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailMovie"),
                  let detailVC = vc as? DetailMovieViewController else { return }
            
            detailVC.id = similarMovies[indexPath.item].id
            show(vc, sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = similarMovies.count
        if indexPath.item == count - Constants.General.OFFSET {
            page += 1
            movieRepo.updateSimilarMovies(with: id, page)
            print(page)
        }
    }
}


