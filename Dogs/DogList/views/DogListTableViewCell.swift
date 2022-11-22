//
//  DogListTableViewCell.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

// Table view cell for dog breeds
final class DogListTableViewCell: UITableViewCell {

    static let cellIdentifier = "DogListTableViewCell"
    static let cellHeight = CGFloat(170)

    // XIB outlets
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!

    // the current breed for the cell
    private var breed: DogBreed?

    deinit {
        // remove listener for the image loader
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // apply styling the cell card
        viewCard.layer.cornerRadius = 10
        viewCard.clipsToBounds = true

        // do not show selections
        selectionStyle = .none

        // add listener for image loader
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventHandler),
                                               name: ImageLoader.notification,
                                               object: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // reset image before reuse
        imageAvatar.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // display the breed for the cell
    func configure(breed: DogBreed) {
        self.breed = breed

        labelName.text = breed.name

        // format the weight and height
        labelWeight.text = breed.weight?.metric.formatWeight()
        labelHeight.text = breed.height?.metric.formatHeight()

        // fetch the image via the image loader
        imageAvatar.fetchImage(url: breed.image?.url)
    }

}

extension DogListTableViewCell {

    // listen for notifications for new images
    @objc func eventHandler(notification: Notification) {
        guard let payload = notification.object as? ImageLoaderPayload else {
            return
        }

        // if the new image is for this cell, update UI
        if payload.url == breed?.image?.url {
            imageAvatar.image = payload.image
        }
    }
    
}
