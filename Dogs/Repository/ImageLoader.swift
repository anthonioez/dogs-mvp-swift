//
//  ImageLoader.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation
import UIKit

final class ImageLoader {

    static let notification = NSNotification.Name.init("imageLoader")
    static var cache = [String: UIImage]()

    static func fetch(url: String) -> UIImage? {
        if let image = cache[url] {
            return image
        }
        return nil
    }

    static func queue(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }

        if let _ = cache[url] {
            return
        }

        let request = URLRequest(url: imageUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        let config = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        let newTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }

                guard let image = UIImage(data: data) else {
                    return
                }

                cache[url] = image

                NotificationCenter.default.post(name: ImageLoader.notification,
                                                object: ImageLoaderPayload(url: url, image: image))
            }
        })
        newTask.resume()
    }

}

struct ImageLoaderPayload {

    var url: String
    var image: UIImage

}
