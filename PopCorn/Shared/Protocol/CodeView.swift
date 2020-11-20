//
//  CodeView.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

protocol CodeView {
    
    func setup()
    
    func setupComponents()
    
    func setupConstraints()
    
    func setupExtraConfigurations()
}

extension CodeView {
    
    func setup() {
        setupComponents()
        
        setupConstraints()
        
        setupExtraConfigurations()
    }
}
