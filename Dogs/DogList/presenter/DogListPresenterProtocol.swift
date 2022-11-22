//
//  DogListPresenterProtocol.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// Defines functions that connects the view controller to the presenter
protocol DogListPresenterProtocol: NSObjectProtocol {

    // called when starting a repository fetch
    func fetchStarting()

    // called when a repository fetch is successful
    func fetchCompleted()

    // called when a repository fetch fails
    func fetchFailed()

    // tell the view controller to navigate to the detail view
    func openDetail(breed: DogBreed)

}
