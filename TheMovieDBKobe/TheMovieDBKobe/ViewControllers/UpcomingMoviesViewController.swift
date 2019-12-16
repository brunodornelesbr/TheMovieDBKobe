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
    let search = UISearchController(searchResultsController: nil)
    var model : UpcomingMovieViewModel!
    var bag = DisposeBag()
    let spacing: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func rxSetup() {
        collectionViewRxSetup()
        searchBarSetup()
    }
    func searchBarSetup() {
        self.navigationController?.definesPresentationContext = true
        self.definesPresentationContext = true
        search.searchBar.barStyle = .black
        search.searchBar.placeholder = "Search for movies"
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = .black
        self.navigationItem.searchController = search
        
        search.searchBar.rx.value.asObservable().filter({($0 ?? "").count > 0 }).debounce(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] searchText in
            self?.searchFor(text: searchText ?? "")
        }).disposed(by: bag)
        
        let cancelButtonClicked = search.searchBar.rx.cancelButtonClicked.asObservable()
        let searchTextEmpty = search.searchBar.rx.text.filter({$0 == "" || $0 == nil}).map { _ in () }
        
        Observable.merge(cancelButtonClicked, searchTextEmpty)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.model.requestAndResetUpcomingMovies()})
            .disposed(by: bag)
    }
    func collectionViewRxSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        upcomingMoviesCollectionView.collectionViewLayout = layout
        
        upcomingMoviesCollectionView.register(UINib(nibName: UpcomingMoviesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: UpcomingMoviesCollectionViewCell.reuseId)
        upcomingMoviesCollectionView.rx.setDelegate(self).disposed(by: bag)
        upcomingMoviesCollectionView.rx.contentOffset.map{
            offset in
            return self.upcomingMoviesCollectionView.isNearBottomEdge(edgeOffset: 30)
        }.filter{
            return $0
        }.throttle(1, latest: false, scheduler: MainScheduler.instance)
            .subscribe({[weak self] _ in
                self?.model.requestMoreItems()
            }).disposed(by: bag)
        
        model.movies.bind(to: upcomingMoviesCollectionView.rx.items(cellIdentifier: UpcomingMoviesCollectionViewCell.reuseId,cellType: UpcomingMoviesCollectionViewCell.self)){
            index,model,cell in
            cell.bindTo(movie: model)
        }.disposed(by: bag)
        
        upcomingMoviesCollectionView.rx.itemSelected.subscribe(onNext: {[weak self] value in
            self?.model.didSelectMovieAt(indexPath : value)
            }).disposed(by: bag)
    }
    
    func searchFor(text: String){
         model.searchMovies(searchText: text)
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
