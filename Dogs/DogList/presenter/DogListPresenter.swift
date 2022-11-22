//
//  DogListPresenter.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

// Presenter in MVP for the Featured Breeds
final class DogListPresenter {

    // weak reference to the view controller for this presenter
    private weak var delegate: DogListPresenterProtocol?

    // api repository via Dependency Injection
    private let repository: DogRepository!

    // stores the list of breeds fetched from the repository
    var breeds = [DogBreed]()

    // stores the last error from a fetch
    var error: DogRepositoryError?

    // return the number of available breeds
    var numberOfBreeds: Int {
        return breeds.count
    }

    // initialize the presenter via dependency injection
    init(repository: DogRepository, delegate: DogListPresenterProtocol) {
        self.repository = repository
        self.delegate = delegate
    }

    // call the repository to fetch breeds while notifying the view controller
    func fetchBreeds() {
        // notify the UI of start of fetch
        error = nil
        delegate?.fetchStarting()

        repository.request(router: DogRouter.getBreed) { (error: DogRepositoryError?, list: [DogBreed]?) in
            // return to the UI thread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                // notify the UI of success/failure
                if let list = list {
                    // return the first 105 breeds
                    self.breeds.append(contentsOf: list.prefix(105))
                    self.delegate?.fetchCompleted()
                } else {
                    self.error = error
                    self.delegate?.fetchFailed()
                }
            }
        }
    }

    // return the dog breed at the given index
    func breedAt(index: Int) -> DogBreed? {
        if index >= 0 && index < breeds.count {
            return breeds[index]
        }
        return nil
    }

    // select the dog breed at the given index
    func selectBreed(index: Int) {
        if let breed = breedAt(index: index) {
            // notify the view controller to navigate to the detail page
            delegate?.openDetail(breed: breed)
        }
    }
}
