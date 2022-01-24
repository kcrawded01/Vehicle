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
    
    func loadImage(_ url: String?, completion: @escaping (UIImage) -> Void) {
        if (url == nil || url!.isEmpty) {
            return;
        }
        
        if let cachedImage = cache.object(forKey:(url! as NSString)) {
            completion(cachedImage)
        }else{
            let urlStr = url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            URLSession.shared.dataTask(with: URL(string: urlStr as String)!) { data, response, error in
                DispatchQueue.main.async {
                    if (error == nil && data != nil) {
                        let image = UIImage(data: data!)!
                        self.cache.setObject(image, forKey: url! as NSString)
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
