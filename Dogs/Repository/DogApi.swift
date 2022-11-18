//
//  DogApi.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

final class DogApi {

    let apiUrl = "https://api.thedogapi.com/v1"
    let apiKey = "" // TODO add your API key

    func fetchBreeds(_ completion: @escaping (String?, [DogBreed]?) -> Void) {
        var allHeaders = [String: String]()
        allHeaders["x-api-key"] = apiKey

        let url = URL(string: "\(apiUrl)/breeds")
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.allHTTPHeaderFields = allHeaders

        let config = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        let newTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(NSLocalizedString("An error occurred!", comment: "") , nil)
                return
            }

            guard let data = data else {
                completion(NSLocalizedString("Invalid data!", comment: ""), nil)
                return
            }

            do {
                let responseObject = try JSONDecoder().decode([DogBreed].self, from: data)
                completion(nil, responseObject)
            } catch {
                completion(NSLocalizedString("Invalid data format!", comment: ""),nil)
            }
        })
        newTask.resume()
    }

}
