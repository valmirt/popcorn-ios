//
//  BaseRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRepository {
    
    func updateImage(baseURL: String, path: String, _ handler: @escaping (UIImage?) -> Void)
}


