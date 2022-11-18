//
//  UIImageView.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

extension UIImageView {

    func fetchImage(url: String?) {
        if let url = url, !url.isEmpty {
            if let img = ImageLoader.fetch(url: url) {
                self.image = img
            } else {
                ImageLoader.queue(url: url)
            }
        } else {
            self.image = nil
        }
    }
}
