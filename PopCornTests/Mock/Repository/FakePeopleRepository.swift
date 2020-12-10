//
//  FakePeopleRepository.swift
//  PopCornTests
//
//  Created by Valmir Junior on 10/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit
@testable import PopCorn

final class FakePeopleRepository: PeopleRepositoryProtocol {
    var errorLoad = false
    var delegate: PeopleRepositoryDelegate?
    
    func detailPeople(with id: Int) {
        if errorLoad {
            delegate?.peopleRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakePeopleNetworkManager.fakeDetailPeople()
            delegate?.peopleRepository(self, didUpdatePeople: fakeResult)
        }
    }
    
    func combinedFilmography(with id: Int) {
        if errorLoad {
            delegate?.peopleRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            let fakeResult = FakePeopleNetworkManager.fakeFilmography()
            delegate?.peopleRepository(self, didUpdateFilmography: fakeResult)
        }
    }
    
    func updateImage(baseURL: String, path: String, _ handler: @escaping (UIImage?) -> Void) {
        if errorLoad {
            delegate?.peopleRepository(self, didUpdateError: NetworkError.defaultError)
        } else {
            handler(UIImage(systemName: "photo"))
        }
    }
}

