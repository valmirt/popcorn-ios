//
//  TVShowManagerDelegate.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol TVShowManagerDelegate {
    func tvShowManager (_ manager: TVShowRepository, didUpdateTVShowList: [TVShow])
    
    func tvShowManager (_ manager: TVShowRepository, didUpdateError: Error)
}

extension TVShowManagerDelegate {
    func tvShowManager (_ manager: TVShowRepository, didUpdateTVShowList: [TVShow]) {
        //this is a empty implementation to allow this method to be optional
    }
}
