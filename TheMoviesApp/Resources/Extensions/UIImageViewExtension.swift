//
//  UIImageViewExtension.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import UIKit

extension UIImageView {
    func imageFromURL(urlString: String, placeholderImage: UIImage?) {
        if self.image == nil {
            self.image = placeholderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) {
            data, response, error in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.image = image
                }
            }
        }.resume()
    }
}
