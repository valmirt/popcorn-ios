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
    
    var type: TypeContent = .movie
    var filter: FilterContent = .popular
    lazy var movieRepo: MovieRepository = ProdMovieRepository()
    lazy var tvRepo: TVShowRepository = ProdTVShowRepository()
    lazy var movies: [Movie] = []
    lazy var tv: [TVShow] = []
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setTitle()
        initReposiotry()
    }
    
    private func setupViews() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        loadingIndicator?.startAnimating()
    }
    
    private func initReposiotry() {
        switch type {
        case .movie:
            movieRepo.delegate = self
            movieRepo.updateMovieList(page, path: getPath())
        case .tvShow:
            tvRepo.delegate = self
            tvRepo.updateTVShowList(page, path: getPath())
        }
    }
    
    private func setTitle() {
        title = filter.rawValue.name
    }
    
    private func errorAlert(message: String?) {
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailMovie" {
            if let detail = segue.destination as? DetailMovieViewController {
                detail.id = sender as? Int ?? 0
            }
        } else if segue.identifier == "goToDetailTV" {
            if let detail = segue.destination as? DetailTVViewController {
                detail.id = sender as? Int ?? 0
            }
        }
    }
    
    private func getPath() -> String {
        return "/\(Constants.Web.VERSION_API)/\(type.rawValue)/\(filter.rawValue.api)"
    }
    
    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch type {
        case .movie:
            return movies.count
        case .tvShow:
            return tv.count
        }
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "movieAndTVCell", for: indexPath) as! GenericTableViewCell
        
        switch type {
        case .movie:
            setContent(movie: movies[indexPath.row], cell: cell)
        case .tvShow:
            setContent(tv: tv[indexPath.row], cell: cell)
        }
        
        cell.setValues()
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        getMorePage(index: indexPath.row)
    }
    
    private func getMorePage(index: Int) {
        switch type {
        case .movie:
            let count = movies.count
            if index == count-4 {
                page += 1
                movieRepo.updateMovieList(page, path: getPath())
            }
        case .tvShow:
            let count = tv.count
            if index == count-4 {
                page += 1
                tvRepo.updateTVShowList(page, path: getPath())
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .movie:
            let movie = movies[indexPath.row]
            performSegue(withIdentifier: "goToDetailMovie", sender: movie.id)
        case .tvShow:
            let dTV = tv[indexPath.row]
            performSegue(withIdentifier: "goToDetailTV", sender: dTV.id)
        }
    }
    
    private func setContent(
        movie: Movie,
        cell: GenericTableViewCell
    ) {
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
    
    private func setContent(
        tv: TVShow,
        cell: GenericTableViewCell
    ) {
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
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 280
    }
}

extension GenericTableViewController: MovieManagerDelegate {
    
    func movieManager(
        _ manager: MovieRepository,
        didUpdateMovieList: [Movie], totalPages: Int
    ) {
        if page < totalPages {
            movies.append(contentsOf: didUpdateMovieList)
            tableView.reloadData()
            loadingIndicator?.stopAnimating()
        }
    }

    func movieManager(_ manager: MovieRepository, didUpdateError: Error) {
        errorAlert(message: didUpdateError.localizedDescription)
        loadingIndicator?.stopAnimating()
    }
}

extension GenericTableViewController: TVShowManagerDelegate {
    
    func tvShowManager(_ manager: TVShowRepository,
                       didUpdateTVShowList: [TVShow],
                       totalPages: Int) {
        if page < totalPages {
            tv.append(contentsOf: didUpdateTVShowList)
            tableView.reloadData()
            loadingIndicator?.stopAnimating()
        }
    }
    
    func tvShowManager(_ manager: TVShowRepository, didUpdateError: Error) {
        errorAlert(message: didUpdateError.localizedDescription)
        loadingIndicator?.stopAnimating()
    }
}
