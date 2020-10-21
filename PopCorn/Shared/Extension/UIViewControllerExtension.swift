//
//  UIViewControllerExtension.swift
//  PopCorn
//
//  Created by Valmir Junior on 20/10/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//
import UIKit

extension UIViewController {
    static func instatiate(from storyBoard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyBoard.instantiateViewController(withIdentifier: name) as! Self
    }
}
