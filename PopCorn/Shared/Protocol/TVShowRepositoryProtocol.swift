//
//  TVShowRepositoryProtocol.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol TVShowRepositoryProtocol: BaseRepositoryProtocol {
    var delegate: TVShowRepositoryDelegate? { get set }
    
    func updateTVShowList(_ page: Int, path: String)
    
    func detailTVShow(with id: Int)
    
    func detailSeason(with id: Int, and seasonNumber: Int)
}
