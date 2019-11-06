//
//  TVShowRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol TVShowRepository: BaseRepository {
    var delegate: TVShowManagerDelegate? { get set }
    
    func updateTVShowList (_ page: Int, path: String)
}
