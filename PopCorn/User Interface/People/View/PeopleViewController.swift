//
//  PeopleViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol PeoplePresenter {
    func showDetailMovie(with viewModel: DetailMovieViewModel?)
    func showDetailTVShow(with viewModel: DetailTVShowViewModel?)
    func exitThisScreen()
}

typealias PeoplePresenterCoordinator = PeoplePresenter & Coordinator

final class PeopleViewController: UIViewController, HasCodeView {
    typealias CustomView = PeopleView
    
    // MARK: - Properties
    var coordinator: PeoplePresenterCoordinator?
    var viewModel: PeopleViewModel?
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = PeopleView()
        setupView()
    }
    
    // MARK: - Methods
    private func showError(with message: String) {
        let alert = ErrorAlertUtil.errorAlert(message: message) { self.coordinator?.exitThisScreen() }
        present(alert, animated: true, completion: nil)
    }
    
    private func setupView() {
        title = "Person"
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("PeopleViewController free")
    }
}

extension PeopleViewController: PeopleViewModelDelegate {
    func onListenerError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.showError(with: errorMessage)
        }
    }
    
    func onListenerPeople() {
        //TODO
    }
}
