//
//  NetworkError.swift
//  Dogs
//
//  Created by Anthony Ezeh on 22/11/2022.
//

import Foundation

public enum DogRepositoryError : String {
    case defaultError = "An error occurred!"
    case invalidRouterRequest = "Invalid router request!"
    case invalidData = "Invalid data!"
    case invalidDataFormat = "Invalid data format!"
}
