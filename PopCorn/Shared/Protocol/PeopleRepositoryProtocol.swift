//
//  PeopleRepositoryProtocol.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

protocol PeopleRepositoryProtocol: BaseRepositoryProtocol {
    var delegate: PeopleRepositoryDelegate? { get set }
    
    func detailPeople(with id: Int)
    
    func combinedFilmography(with id: Int)
}
