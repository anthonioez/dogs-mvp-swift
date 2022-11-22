//
//  DogDetailPresenterProtocol.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// Defines functions that connects the view controller to the presenter
protocol DogDetailPresenterProtocol: NSObjectProtocol {

    // called to display the dog breed
    func loadBreed()

}
