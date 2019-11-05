//
//  GenericTableViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

class GenericTableViewController: UITableViewController {
    var type: String = "movie"
    var filter: String = "popular"
    lazy var movieRepo: MovieRepository = ProdMovieRepository()
    var movies: [Movie]?
//    lazy var tvRepo: TVShowRepository = ProdTVShowRepository()
    var tv: [TVShow]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        initReposiotry()
    }
    
    private func initReposiotry() {
        if type == "movie" {
            movieRepo.delegate = self
            movieRepo.updateMovieList(1, path: "/\(Constants.Web.VERSION_API)/\(type)/\(filter)")
        } else {
//            tvRepo.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieAndTVCell", for: indexPath) as! GenericTableViewCell
        
        if movies != nil {
            let current = movies![indexPath.row]
            if current.backdropPath != nil {
                movieRepo.updateImage(baseURL: Constants.Web.BASE_URL_IMAGE, path: "\(Constants.Web.IMAGE_W780)\(current.backdropPath!)") { image in
                    cell.posterImageView?.image = image
                }
            }
            DispatchQueue.main.async {
                cell.titleLabel?.text = current.title
            }
        } else if tv != nil {
//            let current = tv![indexPath.row]
        }
        

        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }


}

extension GenericTableViewController: MovieManagerDelegate {
    
    func movieManager(_ manager: MovieRepository, didUpdateMovieList: [Movie]) {
        movies = didUpdateMovieList
        tableView.reloadData()
    }

    func movieManager(_ manager: MovieRepository, didUpdateError: Error) {
        
    }
}

extension GenericTableViewController: TVShowManagerDelegate {
    
}
