//
//  GenericTableViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class GenericTableViewController: UITableViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    var type: String = "movie"
    var filter: String = "popular"
    lazy var movieRepo: MovieRepository = ProdMovieRepository()
    var movies: [Movie]?
    lazy var tvRepo: TVShowRepository = ProdTVShowRepository()
    var tv: [TVShow]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        initReposiotry()
        setupViews()
    }
    
    private func setupViews() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        loadingIndicator?.hidesWhenStopped = true
        loadingIndicator?.startAnimating()
    }
    
    private func initReposiotry() {
        let path = getPath()
        if type == "movie" {
            movieRepo.delegate = self
            movieRepo.updateMovieList(1, path: path)
        } else {
            tvRepo.delegate = self
            tvRepo.updateTVShowList(1, path: path)
        }
    }
    
    private func setTitle() {
        switch filter {
        case "popular":
            title = "Popular"
        case "now_playing":
            title = "Now Playing"
        case "top_rated":
            title = "Top Rated"
        default:
            title = "Popular"
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? tv?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieAndTVCell", for: indexPath)
                as! GenericTableViewCell
        
        if movies != nil {
            setContent(movie: movies![indexPath.row], cell: cell)
        } else if tv != nil {
            setContent(tv: tv![indexPath.row], cell: cell)
        }
        cell.setValues()
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    private func setContent(movie: Movie,
                            cell: GenericTableViewCell) {
        if let backdrop = movie.backdropPath {
            let base = Constants.Web.BASE_URL_IMAGE
            let path = "\(Constants.Web.IMAGE_W780)\(backdrop)"
            movieRepo.updateImage(baseURL: base, path: path) { image in
                cell.setImage(image)
            }
        } else {
            cell.setImage(UIImage(systemName: "photo"))
        }
        cell.movie = movie
        cell.tv = nil
    }
    
    private func setContent(tv: TVShow,
                            cell: GenericTableViewCell) {
        if let backdrop = tv.backdropPath {
            let base = Constants.Web.BASE_URL_IMAGE
            let path = "\(Constants.Web.IMAGE_W780)\(backdrop)"
            tvRepo.updateImage(baseURL: base, path: path) { image in
                cell.setImage(image)
            }
        } else {
            cell.setImage(UIImage(systemName: "photo"))
        }
        cell.movie = nil
        cell.tv = tv
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    private func errorAlert(message: String?) {
        let alert = UIAlertController(title: "Error!",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func getPath() -> String {
        if type == "tv" && filter == "now_playing" {
            return "/\(Constants.Web.VERSION_API)/tv/airing_today"
        }
        
        return "/\(Constants.Web.VERSION_API)/\(type)/\(filter)"
    }
}

extension GenericTableViewController: MovieManagerDelegate {
    
    func movieManager(_ manager: MovieRepository, didUpdateMovieList: [Movie]) {
        movies = didUpdateMovieList
        loadingIndicator?.stopAnimating()
        tableView.reloadData()
    }

    func movieManager(_ manager: MovieRepository, didUpdateError: Error) {
        errorAlert(message: didUpdateError.localizedDescription)
    }
}

extension GenericTableViewController: TVShowManagerDelegate {
    
    func tvShowManager(_ manager: TVShowRepository, didUpdateTVShowList: [TVShow]) {
        tv = didUpdateTVShowList
        loadingIndicator?.stopAnimating()
        tableView.reloadData()
    }
    
    func tvShowManager(_ manager: TVShowRepository, didUpdateError: Error) {
        errorAlert(message: didUpdateError.localizedDescription)
    }
}
