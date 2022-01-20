//
//  ImageLoader.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import Foundation
import UIKit

class ImageLoader {
    private let cache = NSCache<NSString, UIImage>()
    
    init() { }
    
    func loadImage(_ url: NSString, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = cache.object(forKey:url) {
            completion(cachedImage)
        }else{
            URLSession.shared.dataTask(with: URL(string: url as String)!) { data, response, error in
                DispatchQueue.main.async {
                    if (error == nil && data != nil) {
                        let image = UIImage(data: data!)!
                        self.cache.setObject(image, forKey: url)
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
