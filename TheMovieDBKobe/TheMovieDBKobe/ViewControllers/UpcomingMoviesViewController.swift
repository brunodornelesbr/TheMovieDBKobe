//
//  ViewController.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 14/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UpcomingMoviesViewController: UIViewController {
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    var model : UpcomingMovieViewModel!
    var bag = DisposeBag()
    let spacing: CGFloat = 10.0
    override func viewDidLoad() {
        super.viewDidLoad()
        rxSetup()
    }
    
    func rxSetup() {
        collectionViewRxSetup()
    }
    func collectionViewRxSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        upcomingMoviesCollectionView.collectionViewLayout = layout
        
        upcomingMoviesCollectionView.register(UINib(nibName: UpcomingMoviesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: UpcomingMoviesCollectionViewCell.reuseId)
        upcomingMoviesCollectionView.rx.setDelegate(self).disposed(by: bag)
        model.movies.bind(to: upcomingMoviesCollectionView.rx.items(cellIdentifier: UpcomingMoviesCollectionViewCell.reuseId,cellType: UpcomingMoviesCollectionViewCell.self)){
            index,model,cell in
            cell.bindTo(movie: model)
        }.disposed(by: bag)
        
    }
}

extension UpcomingMoviesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = spacing
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: 1.2*width)
    }
}
