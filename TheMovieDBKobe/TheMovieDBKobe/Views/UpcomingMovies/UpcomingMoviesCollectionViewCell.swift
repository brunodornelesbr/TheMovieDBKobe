//
//  UpcomingMoviesCollectionViewCell.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import AlamofireImage
class UpcomingMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterLabel: UILabel!
    static var reuseId = "upcomingMoviesCell"
    static var nibName = "UpcomingMoviesCollectionViewCell"
    func bindTo(movie : Movie){
        posterLabel.text = movie.original_title
        guard let posterURL = movie.getPosterURL() else {
            posterImageView.image = ImageConstants.placeholderImage
            return
        }
        posterImageView.af_setImage(withURL: posterURL, placeholderImage: ImageConstants.placeholderImage, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2))
       }
}
