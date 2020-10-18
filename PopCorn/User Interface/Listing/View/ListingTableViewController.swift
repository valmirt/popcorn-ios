//
//  ListingTableViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

final class ListingTableViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: ListingViewModel?
        
    //MARK: - IBOutlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setTitle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailMovie" {
            if let detail = segue.destination as? DetailMovieViewController, let indexPath = tableView.indexPathForSelectedRow {
                detail.viewModel = viewModel?.getDetailMovieViewModel(at: indexPath)
            }
        } else if segue.identifier == "goToDetailTV" {
            if let detail = segue.destination as? DetailTVViewController, let indexPath = tableView.indexPathForSelectedRow {
                detail.viewModel = viewModel?.getDetailTVShowViewModel(at: indexPath)
            }
        }
    }
    
    //MARK: - Methods
    private func setupData() {
        viewModel?.delegate = self
        viewModel?.loadData()
    }
    
    private func setupView() {
        loadingIndicator?.startAnimating()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    @objc private func loadData() {
        viewModel?.loadData()
    }
    
    private func setTitle() {
        title = viewModel?.filterName
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieAndTVCell", for: indexPath) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        viewModel?.setContent(at: indexPath, onComplete: { (image) in
            cell.setImage(image)
        })
        
        cell.configure(with: viewModel?.getMediaViewModel(at: indexPath))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.getMorePage(index: indexPath.row)
    }
}

//MARK: - Listing ViewModel delegate
extension ListingTableViewController: ListingViewModelDelegate {
    func onListing(didUpdatedMovies: Bool, error: String) {
        DispatchQueue.main.async {
            if !didUpdatedMovies {
                self.errorAlert(message: error)
            }
            
            self.tableView.reloadData()
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func onListing(didUpdatedTvShows: Bool, error: String) {
        DispatchQueue.main.async {
            if !didUpdatedTvShows {
                self.errorAlert(message: error)
            }
            self.tableView.reloadData()
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
}
