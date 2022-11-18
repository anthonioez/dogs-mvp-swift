//
//  DogListPresenterProtocol.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

protocol DogListPresenterProtocol: NSObjectProtocol {

    func fetchStarting()
    func fetchCompleted()
    func fetchFailed()

    func openDetail(breed: DogBreed)

}
