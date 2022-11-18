//
//  DogDetailViewController.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

final class DogDetailViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!

    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var imageAvatar: UIImageView!

    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelTemperament: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    @IBOutlet weak var labelOrigin: UILabel!

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonFavorites: UIButton!

    var presenter: DogDetailPresenter?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewAvatar.layer.cornerRadius = 10
        viewAvatar.clipsToBounds = true

        buttonBack.setTitle("", for: .normal)
        buttonFavorites.layer.cornerRadius = 10

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventHandler),
                                               name: ImageLoader.notification,
                                               object: nil)

        presenter?.loadDetail()
    }

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func onFavorite(_ sender: Any) {
        presenter?.addToFavorites()
    }
    
}

extension DogDetailViewController: DogDetailPresenterProtocol {

    func loadBreed() {
        let breed = presenter?.breed

        labelTitle.text = breed?.name

        imageAvatar.fetchImage(url: breed?.image?.url)

        labelWeight.text = breed?.weight?.metric.formatWeight()
        labelHeight.text = breed?.height?.metric.formatHeight()

        labelTemperament.text = breed?.temperament ?? " "
        labelGroup.text = breed?.breed_group ?? " "
        labelOrigin.text = breed?.origin ?? " "
    }

}

extension DogDetailViewController {

    @objc func eventHandler(notification: Notification) {
        guard let payload = notification.object as? ImageLoaderPayload else {
            return
        }

        if payload.url == presenter?.breed?.image?.url {
            imageAvatar.image = payload.image
        }
    }

}
