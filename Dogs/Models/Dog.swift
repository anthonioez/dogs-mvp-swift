//
//  Dog.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// TODO use CodingKey

struct DogBreed: Decodable, Identifiable {

    let id: Int
    let name: String?

    let weight: DogUnit?
    let height: DogUnit?

    let image: DogImage?

    let temperament: String?
    let breed_group: String?

    let origin: String?

}

struct DogUnit: Decodable {

    let imperial: String
    let metric: String

}

struct DogImage: Decodable {

    let url: String

}
