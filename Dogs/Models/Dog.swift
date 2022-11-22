//
//  Dog.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// TODO use CodingKey

// dog breed Model
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

// dog breed unit
struct DogUnit: Decodable {

    let imperial: String
    let metric: String

}

// dog breed image 
struct DogImage: Decodable {

    let url: String

}
