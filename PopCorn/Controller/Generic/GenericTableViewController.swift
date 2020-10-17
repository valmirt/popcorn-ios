//
//  GenericTableViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class GenericTableViewController: UITableViewController {
    // MARK: - Properties
    var type: TypeContent = .movie
    var filter: FilterContent = .popular
    lazy var movieRepo: MovieRepositoryProtocol = MovieRepository()
    lazy var tvRepo: TVShowRepositoryProtocol = TVShowRepository()
    lazy var movies: [Movie] = []
    lazy var tv: [TVShow] = []
    private var page = Constants.General.FIRST
    private var reloadData = false
        
    //MARK: - IBOutlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setTitle()
        initReposiotry()
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
    
    //MARK: - Methods
    private func setupViews() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        loadingIndicator?.startAnimating()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    private func initReposiotry() {
        switch type {
        case .movie:
            movieRepo.delegate = self
        case .tvShow:
            tvRepo.delegate = self
        }
        loadData()
    }
    
    @objc
    private func loadData() {
        page = Constants.General.FIRST
        reloadData = true
        switch type {
        case .movie:
            movieRepo.updateMovieList(page, path: getPath())
        case .tvShow:
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
    
    private func getPath() -> String {
        return "/\(Constants.Web.VERSION_API)/\(type.rawValue)/\(filter.rawValue.api)"
    }
    
    private func getMorePage(index: Int) {
        switch type {
        case .movie:
            let count = movies.count
            if index == count - Constants.General.OFFSET {
                page += 1
                movieRepo.updateMovieList(page, path: getPath())
            }
        case .tvShow:
            let count = tv.count
            if index == count - Constants.General.OFFSET {
                page += 1
                tvRepo.updateTVShowList(page, path: getPath())
            }
        }
    }
    
    private func setContent(movie: Movie, cell: GenericTableViewCell) {
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
    
    private func setContent(tv: TVShow, cell: GenericTableViewCell) {
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch type {
        case .movie:
            return movies.count
        case .tvShow:
            return tv.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieAndTVCell", for: indexPath) as! GenericTableViewCell
        
        switch type {
        case .movie:
            setContent(movie: movies[indexPath.row], cell: cell)
        case .tvShow:
            setContent(tv: tv[indexPath.row], cell: cell)
        }
        
        cell.setValues()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        getMorePage(index: indexPath.row)
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
}

//MARK: - Movie manager delegate
extension GenericTableViewController: MovieRepositoryDelegate {
    
    func movieRepository(_ manager: MovieRepository, didUpdateMovieList: [Movie], totalPages: Int) {
        if page < totalPages {
            if reloadData {
                movies.removeAll()
                reloadData = false
            }
            
            movies.append(contentsOf: didUpdateMovieList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadingIndicator?.stopAnimating()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    func movieRepository(_ manager: MovieRepository, didUpdateError: Error) {
        DispatchQueue.main.async {
            self.errorAlert(message: didUpdateError.localizedDescription)
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
}

//MARK: - Tv Show manager delegate
extension GenericTableViewController: TVShowRepositoryDelegate {
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateTVShowList: [TVShow], totalPages: Int) {
        if page < totalPages {
            if reloadData {
                tv.removeAll()
                reloadData = false
            }
            
            tv.append(contentsOf: didUpdateTVShowList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadingIndicator?.stopAnimating()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    func tvShowRepository(_ manager: TVShowRepository, didUpdateError: Error) {
        DispatchQueue.main.async {
            self.errorAlert(message: didUpdateError.localizedDescription)
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
}
