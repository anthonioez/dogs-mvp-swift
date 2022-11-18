//
//  DogDetailPresenter.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

final class DogDetailPresenter {

    private weak var delegate: DogDetailPresenterProtocol?

    var breed: DogBreed?

    init(breed: DogBreed, delegate: DogDetailPresenterProtocol) {
        self.breed = breed
        self.delegate = delegate
    }

    func loadDetail() {
        delegate?.loadBreed()
    }

    func addToFavorites() {
        // TODO
    }
}
