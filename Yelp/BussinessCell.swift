//
//  BussinessCell.swift
//  Yelp
//
//  Created by Tang Zhang on 9/2/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BussinessCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL)
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            ratingImageView.setImageWithURL(business.ratingImageURL)
            categoryLabel.text = business.categories
            reviewsCountLabel.text = "\(business.reviewCount!) reviews"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
