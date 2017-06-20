//
//  MovieItemCollectionViewCell.swift
//  MovieSearch
//
//  Created by Nathan Chen on 6/19/17.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    override func awakeFromNib() {
        movieImageView.layer.cornerRadius = 20
        movieImageView.clipsToBounds = true
    }
}
