//
//  ImageService.swift
//  PopCorn
//
//  Created by Valmir Torres on 31/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation
import UIKit

struct ImageService {
    private static let cache = NSCache<NSString, UIImage>()
    
    private static func downloadImage(
        withUrl url: URL,
        handler: @escaping (UIImage?) -> Void
    ) {
        let dataTask = URLSession.shared.dataTask(with: url) {data ,_ ,_ in
            var downloadedImage: UIImage?
            
            if let safe = data {
                downloadedImage = UIImage(data: safe)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                handler(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withUrl url: URL, handler: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            handler(image)
        } else {
            downloadImage(withUrl: url, handler: handler)
        }
    }
}
