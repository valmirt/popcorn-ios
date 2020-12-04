//
//  PeopleRepository.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

final class PeopleRepository: BaseRepository, PeopleRepositoryProtocol {
    
    weak var delegate: PeopleRepositoryDelegate?
    
    func detailPeople(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/person/\(id)", queries, People.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.peopleRepository(self, didUpdatePeople: data)
            case .failure(let error):
                self.delegate?.peopleRepository(self, didUpdateError: error)
            }
        }
    }
    
    func combinedFilmography(with id: Int) {
        let queries = [
            URLQueryItem(name: "api_key", value: Web.API_KEY)
        ]
        
        load("/\(Web.VERSION_API)/person/\(id)/combined_credits", queries, Filmography.self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.delegate?.peopleRepository(self, didUpdateFilmography: data)
            case .failure(let error):
                self.delegate?.peopleRepository(self, didUpdateError: error)
            }
        }
    }
}

//MARK: - People Repository delegate
protocol PeopleRepositoryDelegate: AnyObject {
    func peopleRepository (_ manager: PeopleRepositoryProtocol, didUpdatePeople: People)
    
    func peopleRepository (_ manager: PeopleRepositoryProtocol, didUpdateFilmography: Filmography)
    
    func peopleRepository (_ manager: PeopleRepositoryProtocol, didUpdateError: Error)
}

//MARK: - Default delegate implementation
extension PeopleRepositoryDelegate {
    func peopleRepository (_ manager: PeopleRepositoryProtocol, didUpdatePeople: People) {
        //this is an empty implementation to allow this method to be optional
    }
    
    func peopleRepository (_ manager: PeopleRepositoryProtocol, didUpdateFilmography: Filmography) {
        //this is an empty implementation to allow this method to be optional
    }
}
