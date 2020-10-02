//
//  CircleImageView.swift
//  PopCorn
//
//  Created by Valmir Junior on 01/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
