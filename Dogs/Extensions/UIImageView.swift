//
//  UIImageView.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

extension UIImageView {

    // fetch image by its url
    func fetchImage(url: String?) {
        // if valid url
        if let url = url, !url.isEmpty {
            // if already fetched, return image
            if let img = ImageLoader.fetch(url: url) {
                self.image = img
            } else {
                // else queue the url for download
                ImageLoader.queue(url: url)
            }
        } else {
            self.image = nil
        }
    }
}
