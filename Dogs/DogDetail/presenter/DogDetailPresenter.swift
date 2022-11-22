//
//  DogDetailPresenter.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// Presenter in MVP for the Detailed View
final class DogDetailPresenter {

    // weak reference to the view controller for this presenter
    private weak var delegate: DogDetailPresenterProtocol?

    // hold the breed to be displayed by the controller
    var breed: DogBreed?

    // initialize the presenter via dependency injection
    init(breed: DogBreed, delegate: DogDetailPresenterProtocol) {
        self.breed = breed
        self.delegate = delegate
    }

    // this is called when the view controller is ready to display content
    func loadDetail() {
        // tell the view controller to display it's content
        delegate?.loadBreed()
    }

    // this is called when the 'Add to Favorite' button is tapped
    func addToFavorites() {
        // TODO not implemented
    }
    
}
