//
//  SeasonDetailViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 12/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SeasonDetailViewController: UIViewController, HasCodeView {
    typealias CustomView = SeasonDetailView
    
    // MARK: - Properties
    var coordinator: SeasonDetailCoordinator?
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
        viewModel?.delegate = self
        viewModel?.loadData()
    }
    
    private func fillData() {
        //TODO
    }
}

//MARK: - Season Detail ViewModel Delegate
extension SeasonDetailViewController: SeasonDetailViewModelDelegate {
    func onListenerError(with message: String) {
        DispatchQueue.main.async {
            //TODO
        }
    }
    
    func onListenerSeasonDetail() {
        DispatchQueue.main.async {
            self.fillData()
        }
    }
}

