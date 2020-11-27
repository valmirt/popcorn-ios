//
//  ErrorAlertUtil.swift
//  PopCorn
//
//  Created by Valmir Junior on 27/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

struct ErrorAlertUtil {
    static func errorAlert(title: String? = "Error!", message: String?, onComplete: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            onComplete?()
        })
        
        return alert
    }
}
