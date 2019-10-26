//
//  MovieManagerDelegate.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

protocol MovieManagerDelegate {
    func movieManager (_ manager: MovieRepository, didUpdatePopularList: [Movie])
    
    func movieManager (_ manager: MovieRepository, didUpdateNowPlayingList: [Movie])
    
    func movieManager (_ manager: MovieRepository, didUpdateTopRatedList: [Movie])
    
    func movieManager (_ manager: MovieRepository, didUpdateError: Error)
}

//MARK: - Default Implementations

extension MovieManagerDelegate {
    func movieManager (_ manager: MovieRepository, didUpdatePopularList: [Movie]) {
        //this is a empty implementation to allow this method to be optional
    }
    
    func movieManager (_ manager: MovieRepository, didUpdateNowPlayingList: [Movie]) {
        //this is a empty implementation to allow this method to be optional
    }
    
    func movieManager (_ manager: MovieRepository, didUpdateTopRatedList: [Movie]) {
        //this is a empty implementation to allow this method to be optional
    }
}
