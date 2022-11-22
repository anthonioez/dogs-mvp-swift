//
//  DogDetailViewController.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

// View (ViewController) in MVP for the Detailed View
final class DogDetailViewController: UIViewController {

    // XIB outlets
    @IBOutlet weak var labelTitle: UILabel!

    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var imageAvatar: UIImageView!

    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelTemperament: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    @IBOutlet weak var labelOrigin: UILabel!

    @IBOutlet weak var buttonFavorites: UIButton!

    // strong reference to the presenter
    var presenter: DogDetailPresenter?

    deinit {
        // remove listener for the image loader
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the navigation bar
        title = NSLocalizedString("Detailed View", comment: "")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // apply styling the dog image
        viewAvatar.layer.cornerRadius = 10
        viewAvatar.clipsToBounds = true

        // apply styling to favorite button
        buttonFavorites.layer.cornerRadius = 10

        // add listener for image loader
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventHandler),
                                               name: ImageLoader.notification,
                                               object: nil)

        // notify the presenter that this view is ready
        presenter?.loadDetail()
    }

    // Action for 'Add to Favorite' button
    @IBAction func onFavorite(_ sender: Any) {
        // notify the presenter that the favorite button was tapped
        presenter?.addToFavorites()
    }
    
}

extension DogDetailViewController: DogDetailPresenterProtocol {

    // display the dog breed
    func loadBreed() {
        let breed = presenter?.breed

        labelTitle.text = breed?.name

        // fetch the image via the image loader
        imageAvatar.fetchImage(url: breed?.image?.url)

        // format the weight and height
        labelWeight.text = breed?.weight?.metric.formatWeight()
        labelHeight.text = breed?.height?.metric.formatHeight()

        // populate other data
        labelTemperament.text = breed?.temperament ?? " "
        labelGroup.text = breed?.breed_group ?? " "
        labelOrigin.text = breed?.origin ?? " "
    }

}

extension DogDetailViewController {

    // listen for notifications for new images
    @objc func eventHandler(notification: Notification) {
        guard let payload = notification.object as? ImageLoaderPayload else {
            return
        }

        // if the new image is for this dog breed, update UI
        if payload.url == presenter?.breed?.image?.url {
            imageAvatar.image = payload.image
        }
    }

}
