//
//  EpisodeDetailViewController.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class EpisodeDetailViewController: UIViewController, HasCodeView {
    typealias CustomView = EpisodeDetailView
    
    // MARK: - Properties
    var coordinator: EpisodeDetailCoordinator?
    var viewModel: EpisodeDetailViewModel?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        coordinator?.didFinish(child: nil)
        print("EpisodeDetailViewController free")
    }
    
    // MARK: - Methods
    private func setupView() {
        view = EpisodeDetailView()
        customView?.titleLabel.text = viewModel?.title
        customView?.airDateLabel.text = viewModel?.airDate
        customView?.seasonNumberLabel.text = viewModel?.seasonNumber
        customView?.episodeNumberLabel.text = viewModel?.episodeNumber
        
        viewModel?.getImage(onComplete: { image in
            self.customView?.backdropImage.image = image ?? UIImage(systemName: "photo")
        })
    }
}
