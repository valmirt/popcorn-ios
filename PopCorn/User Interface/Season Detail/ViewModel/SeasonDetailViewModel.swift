//
//  SeasonDetailViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 21/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

protocol SeasonDetailViewModelDelegate: AnyObject {
    func onListenerError(with message: String)
    func onListenerSeasonDetail()
}

final class SeasonDetailViewModel {
    
    //MARK: - Properties
    private let id: Int
    private var repository: TVShowRepositoryProtocol
    weak var delegate: SeasonDetailViewModelDelegate?
    
    
    init(id: Int, _ repository: TVShowRepositoryProtocol = TVShowRepository()) {
        self.id = id
        self.repository = repository
    }
    
    //MARK: - Methods
    func loadData() {
        repository.delegate = self
        
    }
}

extension SeasonDetailViewModel: TVShowRepositoryDelegate {
    func tvShowRepository(_ manager: TVShowRepositoryProtocol, didUpdateError: Error) {
        
    }
    
    
}
