//
//  DetailsMovieViewController.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage
class DetailsMovieViewController: UIViewController {
    @IBOutlet weak var backdropEffect: UIVisualEffectView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var model : DetailMovieViewModel!
    var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureRx(){
        model.movie.asObservable().subscribe(onNext : {
          [weak self]  movie in
            guard let self = self else {return}
            self.genreLabel.text = "Genre: \(movie.genres)"
             self.releaseDateLabel.text = "Release date: \(DateFormatter.formatToShow(date: movie.releaseDate))"
            self.aboutTextView.text = movie.overview
            self.movieTitle.text = movie.original_title
            guard let backdropURL = movie.getBackdropURL() else {
                self.backdropEffect.effect = nil
                return
            }
            self.backdropImage.af_setImage(withURL: backdropURL, placeholderImage: ImageConstants.placeholderImage, filter: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2))
            }).disposed(by: bag)
    }
}
