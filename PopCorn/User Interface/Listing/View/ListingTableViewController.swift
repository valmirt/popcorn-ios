//
//  ListingTableViewController.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

protocol DetailMediaPresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?)
    func showDetailTVShow(with viewModel: DetailTVShowViewModel?)
}

typealias DetailMediaPresenterCoordinator = DetailMediaPresenter & Coordinator

final class ListingTableViewController: UITableViewController {
    // MARK: - Properties
    var viewModel: ListingViewModel?
    var coordinator: DetailMediaPresenterCoordinator?
        
    //MARK: - IBOutlets
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setTitle()
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
        cell.configure(with: viewModel?.getMediaViewModel(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.getMorePage(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.isMovie ?? true {
            coordinator?.showDetailMovie(with: viewModel?.getDetailMovieViewModel(at: indexPath))
        } else {
            coordinator?.showDetailTVShow(with: viewModel?.getDetailTVShowViewModel(at: indexPath))
        }
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("ListingTableViewController free")
    }
}

//MARK: - Listing ViewModel delegate
extension ListingTableViewController: ListingViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: errorMessage)
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func onListenerMediaList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingIndicator?.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }
}
