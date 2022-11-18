//
//  DogListPresenter.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

final class DogListPresenter {

    private weak var delegate: DogListPresenterProtocol?

    private let api: DogApi!

    var breeds = [DogBreed]()
    var error: String?

    var numberOfBreeds: Int {
        return breeds.count
    }

    init(api: DogApi, delegate: DogListPresenterProtocol) {
        self.api = api
        self.delegate = delegate
    }

    func fetchBreeds() {
        error = nil
        delegate?.fetchStarting()

        api.fetchBreeds { error, list in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                if let list = list {
                    self.breeds.append(contentsOf: list.prefix(105))
                    self.delegate?.fetchCompleted()
                } else {
                    self.error = error
                    self.delegate?.fetchFailed()
                }
            }
        }
    }

    func breedAt(index: Int) -> DogBreed? {
        if index >= 0 && index < breeds.count {
            return breeds[index]
        }
        return nil
    }

    func selectBreed(index: Int) {
        if let breed = breedAt(index: index) {
            delegate?.openDetail(breed: breed)
        }
    }
}
