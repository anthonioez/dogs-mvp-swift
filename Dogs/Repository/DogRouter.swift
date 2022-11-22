//
//  DogRouter.swift
//  Dogs
//
//  Created by Anthony Ezeh on 22/11/2022.
//

import Foundation

// router for Dog Breed API
enum DogRouter {

    private static let apiKey = "" // TODO add your API key
    private static let apiUrl = "https://api.thedogapi.com/v1"

    // list of all routes
    case getBreed

    // string for http methods
    private enum HTTPMethod {
        case get
        case post

        var value: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            }
        }
    }

    // http method for each route
    private var method: HTTPMethod {
        switch self {
        case .getBreed:
            return .get
        }
    }

    // API path for each route
    private var path: String {
        switch self {
        case .getBreed:
            return "/breeds"
        }
    }

    // generate a URLRequest for this route
    func request() -> URLRequest? {
        let urlString = "\(DogRouter.apiUrl)\(path)"

        // make sure URL is valid
        guard let url = URL(string: urlString) else {
            return nil
        }

        // setup http headers
        var allHeaders = [String: String]()
        allHeaders["x-api-key"] = DogRouter.apiKey
        allHeaders["Content-Type"] = "application/json"

        // populate properties for http request
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.allHTTPHeaderFields = allHeaders
        request.httpMethod = method.value

        switch self {
        case .getBreed:
            return request
        }
    }
    
}
