//
//  UpcomingMovieViewModel.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
enum UpcomingMovieContext {
    case searching
    case upcomingMovies
}
class UpcomingMovieViewModel : BaseViewModel {
     var request : Request
     var router : Router
    private var availableMovies = BehaviorRelay<[Movie]>(value : [])
    private var currentPage = 0
    private var maxPages = Int.max
    private var requesting = BehaviorRelay<Bool>(value: false)
    private var context = UpcomingMovieContext.upcomingMovies
    private var lastSearchQuery = ""
    var movies : Observable<[Movie]> {return availableMovies.asObservable()}
    
    init(request : Request,router : Router) {
        self.request = request
        self.router = router
          super.init()
        requestGenres()
    }
    
    private func requestGenres(){
        request.getGenres{
            [weak self]  _,error in
            if error != nil {
                self?.requestGenres()
            }
        }
    }
    
    func getUpcomingMovies(){
        guard currentPage < maxPages,requesting.value == false else {return}
        currentPage = currentPage + 1
        request.getUpcomingMovieList(page: currentPage){ [weak self]
            value,error in
            self?.handleApiCallback(value: value, error: error)
        }
    }
    func requestMoreItems() {
        switch context {
        case .upcomingMovies:
            getUpcomingMovies()
        case .searching:
            searchMovies(searchText: lastSearchQuery)
        }
    }
    
    func searchMovies(searchText: String){
        if searchText != lastSearchQuery {
            resetMovies()
            lastSearchQuery = searchText
        }
        context = .searching
        guard currentPage < maxPages,requesting.value == false else {return}
        currentPage = currentPage + 1
        
        request.searchForMovie(query : lastSearchQuery , page: currentPage){ [weak self] value, error in
            self?.handleApiCallback(value: value, error: error)
        }
        
    }
    
    func handleApiCallback(value : UpcomingMoviesRequestObject?, error : Error?){
        if let error = error {
            self.errorThreatment(error: error)
        }
        
        if let value = value {
            var movies = self.availableMovies.value
            movies.append(contentsOf: value.movieList)
            self.availableMovies.accept(movies)
            self.currentPage = value.page
            self.maxPages = value.totalPages
        }
    }
    
    func requestAndResetUpcomingMovies() {
        resetMovies()
        context = .upcomingMovies
        requestMoreItems()
    }
    
    func resetMovies(){
        currentPage = 0
        availableMovies.accept([])
    }
    
    func errorThreatment(error: Error){
        self.errorMessageToDisplay.accept(error.localizedDescription)
    }
    
    func didSelectMovieAt(indexPath : IndexPath){
        let movie = availableMovies.value[indexPath.row]
        router.routeToDetailsMovie(movie : movie)
    }
}
