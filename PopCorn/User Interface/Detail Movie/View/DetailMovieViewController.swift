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
    var viewModel: DetailMovieViewModel?
    
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
        
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        performLoading(status: true)
        viewModel?.delegate = self
        viewModel?.loadData()
    }
    
    private func fillData() {
        labelTitle.text = viewModel?.title
        labelGenres.text = viewModel?.genres
        labelCountries.text = viewModel?.countries
        labelStatus.text = viewModel?.status
        labelReleaseDate.text = viewModel?.date
        labelRuntime.text = viewModel?.runtime
        tvOverview.text = viewModel?.overview
        labelCompanies.text = viewModel?.companies
        viewModel?.getImage { image in
            self.ivPoster.image = image
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
}

//MARK: - Collection view
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvCastingAndCrew {
            return viewModel?.creditCount ?? 0
        } else {
            return viewModel?.similarMoviesCount ?? 0
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
        cell.configure(with: viewModel?.getCreditCellViewModel(at: indexPath))
        return cell
    }
    
    private func defineSimilarMoviesCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSimilarMovies.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! SimilarMovieCollectionViewCell
        cell.configure(with: viewModel?.getSimilarMovieViewModel(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.cvSimilarMovies {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailMovie"),
                  let detailVC = vc as? DetailMovieViewController else { return }
            
            detailVC.viewModel = viewModel?.getDetailViewModel(at: indexPath)
            show(vc, sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.getMorePages(at: indexPath)
    }
}

//MARK: - Detail Movie delegate
extension DetailMovieViewController: DetailMovieViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: errorMessage)
        }
    }
    
    func onListenerDetailMovie() {
        DispatchQueue.main.async {
            self.fillData()
            self.performLoading(status: false)
        }
    }
    
    func onListenerCredit() {
        DispatchQueue.main.async {
            self.cvCastingAndCrew.reloadData()
            self.performLoading(status: false)
        }
    }
    
    func onListenerSimilarMovies() {
        DispatchQueue.main.async {
            self.cvSimilarMovies.reloadData()
            self.performLoading(status: false)
        }
    }
}


