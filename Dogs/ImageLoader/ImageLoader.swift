//
//  ImageLoader.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation
import UIKit

// handles loading images
// keeps a cache of already loaded images
// sends a notification when an image is loaded
final class ImageLoader {

    // notification sent when an image is loaded
    static let notification = NSNotification.Name.init("imageLoader")

    // stores all loaded images
    static var cache = [String: UIImage]()

    // given a URL, check if the image has been downloaded
    static func fetch(url: String) -> UIImage? {
        if let image = cache[url] {
            return image
        }
        return nil
    }

    // given a URL, queue an image for downnload
    static func queue(url: String) {
        // is url valid?
        guard let imageUrl = URL(string: url) else {
            return
        }

        // is url already processed?
        if let _ = cache[url] {
            return
        }

        // setup url request
        let request = URLRequest(url: imageUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        let config = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        let newTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            // switch to UI thread
            DispatchQueue.main.async {
                // check for errors
                guard error == nil else {
                    return
                }

                // check for invalid data
                guard let data = data else {
                    return
                }

                // convert data to image
                guard let image = UIImage(data: data) else {
                    return
                }

                // store image
                cache[url] = image

                // notify any observer
                NotificationCenter.default.post(name: ImageLoader.notification,
                                                object: ImageLoaderPayload(url: url, image: image))
            }
        })

        // start the task
        newTask.resume()
    }

}
