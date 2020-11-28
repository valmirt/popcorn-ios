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
        customView?.creditCollectionView.delegate = self
        customView?.creditCollectionView.dataSource = self
        customView?.titleLabel.text = viewModel?.title
        customView?.airDateLabel.text = viewModel?.airDate
        customView?.seasonNumberLabel.text = viewModel?.seasonNumber
        customView?.episodeNumberLabel.text = viewModel?.episodeNumber
        customView?.overviewTextView.text = viewModel?.overview
        
        viewModel?.getImage(onComplete: { image in
            self.customView?.backdropImage.image = image ?? UIImage(systemName: "photo")
        })
    }
}

//MARK: - CollectionView datasouce and delegate
extension EpisodeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.creditCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customView?.creditCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailView.cellIdentifier, for: indexPath) as! CrewAndGuestCollectionViewCell
        cell.configure(with: viewModel?.getCreditCellViewModel(at: indexPath))
        return cell
    }
}

