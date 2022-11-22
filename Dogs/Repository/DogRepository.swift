//
//  DogRepository.swift
//  Dogs
//
//  Created by Anthony Ezeh on 22/11/2022.
//

import Foundation

// Repository for Dog Breed API
final class DogRepository {

    // start the API request
    func request<T: Decodable>(router: DogRouter, completion: @escaping (DogRepositoryError?, T?) -> ()) {
        //check for valid non-nil requests
        guard let request = router.request() else {
            completion(.invalidRouterRequest, nil)
            return
        }

        // prepare url session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            // check for errors
            guard error == nil else {
                completion(.defaultError , nil)
                return
            }

            // check for non-nil data
            guard let data = data else {
                completion(.invalidData, nil)
                return
            }

            do {
                // decode json to generic type
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(nil, responseObject)
            } catch {
                // catch json error
                completion(.invalidDataFormat, nil)
            }
        }

        // make the request
        task.resume()
    }

}
