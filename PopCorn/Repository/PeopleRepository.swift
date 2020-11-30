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
    
    
}

//MARK: - People Repository delegate
protocol PeopleRepositoryDelegate: AnyObject {
    
}

//MARK: - Default delegate implementation
extension PeopleRepositoryDelegate {
    
    
}
