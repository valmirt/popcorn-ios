//
//  SeasonDetailViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 12/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol SeasonDetailPresenter {
    func showEpisodeDetail(with viewModel: EpisodeDetailViewModel?)
    func exitThisScreen()
}

typealias SeasonDetailPresenterCoordinator = SeasonDetailPresenter & Coordinator

final class SeasonDetailViewController: UIViewController, HasCodeView {
    typealias CustomView = SeasonDetailView
    
    // MARK: - Properties
    var coordinator: SeasonDetailPresenterCoordinator?
    var viewModel: SeasonDetailViewModel?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("SeasonViewController free")
    }
    
    // MARK: - Methods
    private func setupView() {
        view = SeasonDetailView()
        customView?.episodesTableView.dataSource = self
        customView?.episodesTableView.delegate = self
        viewModel?.delegate = self
        viewModel?.loadData()
        performLoading(status: true)
    }
    
    private func fillData() {
        title = viewModel?.title
        customView?.overviewTextView.text = viewModel?.overview
        customView?.airDateLabel.text = viewModel?.airDate
        customView?.seasonNumberLabel.text = viewModel?.numberSeason
        customView?.episodesTableView.reloadData()
    }
    
    private func performLoading(status: Bool) {
        if status {
            customView?.loadingContainer.isHidden = false
            customView?.loadingSpinner.startAnimating()
        } else {
            customView?.loadingContainer.isHidden = true
            customView?.loadingSpinner.stopAnimating()
        }
    }
    
    private func errorAlert(message: String?) {
        let alert = ErrorAlertUtil.errorAlert(message: message) { self.coordinator?.exitThisScreen() }
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableView data source
extension SeasonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.countEpisodes ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customView?.episodesTableView.dequeueReusableCell(
            withIdentifier: SeasonDetailView.cellIdentifier, for: indexPath
        ) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel?.getEpisodeViewModel(at: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        coordinator?.showEpisodeDetail(with: viewModel?.getEpisodeDetailViewModel(at: indexPath))
    }
}

//MARK: - Season Detail ViewModel Delegate
extension SeasonDetailViewController: SeasonDetailViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: errorMessage)
        }
    }
    
    func onListenerSeasonDetail() {
        DispatchQueue.main.async {
            self.fillData()
            self.performLoading(status: false)
        }
    }
}

