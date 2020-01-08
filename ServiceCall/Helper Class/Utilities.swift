//
//  Utilities.swift
//
//  Created by gowri anguraj  on 12/20/19.
//  Copyright © 2019 gowri anguraj . All rights reserved.
//

import Foundation
import UIKit

var cacheForImage = NSCache<AnyObject, AnyObject> ()

extension UIImageView {
    func fetchImageFromURLStringAndCache(urlString: String) {
        if let cacheImage = cacheForImage.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Couldn't download image: \(error)")
                return
            }
            
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                cacheForImage.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.0f", self)
    }
}

extension String {
    public func toPhoneNumber() -> String {
        return replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
