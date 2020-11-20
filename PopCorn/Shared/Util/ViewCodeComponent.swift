//
//  ViewCodeComponent.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

@propertyWrapper
struct ViewCodeComponent<T: UIView> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
