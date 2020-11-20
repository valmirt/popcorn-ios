//
//  HasCodeView.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol HasCodeView {
    associatedtype CustomView: UIView
}

extension HasCodeView where Self: UIViewController {
    var customView: CustomView? {
        return view as? CustomView
    }
}
