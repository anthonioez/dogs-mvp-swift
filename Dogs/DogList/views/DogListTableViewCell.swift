//
//  DogListTableViewCell.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

final class DogListTableViewCell: UITableViewCell {

    static let cellIdentifier = "DogListTableViewCell"
    static let cellHeight = CGFloat(170)

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!

    private var breed: DogBreed?

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewCard.layer.cornerRadius = 10
        viewCard.clipsToBounds = true

        selectionStyle = .none

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(eventHandler),
                                               name: ImageLoader.notification,
                                               object: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageAvatar.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(breed: DogBreed) {
        self.breed = breed

        labelName.text = breed.name

        labelWeight.text = breed.weight?.metric.formatWeight()
        labelHeight.text = breed.height?.metric.formatHeight()

        imageAvatar.fetchImage(url: breed.image?.url)
    }

}

extension DogListTableViewCell {

    @objc func eventHandler(notification: Notification) {
        guard let payload = notification.object as? ImageLoaderPayload else {
            return
        }

        if payload.url == breed?.image?.url {
            imageAvatar.image = payload.image
        }
    }
    
}
