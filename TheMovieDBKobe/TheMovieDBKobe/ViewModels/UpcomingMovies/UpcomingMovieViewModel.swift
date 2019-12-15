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
class UpcomingMovieViewModel : BaseViewModel {
   var request : Request
   private var availableMovies = BehaviorRelay<[Movie]>(value : [])
   private var currentPage = 0
   private var maxPages = Int.max
   private var requesting = BehaviorRelay<Bool>(value: false)
   
   var movies : Observable<[Movie]> {return availableMovies.asObservable()}
    init(request : Request) {
        self.request = request
    }
    
    func getUpcomingMovies(){
        guard currentPage < maxPages,requesting.value == false else {return}
        currentPage = currentPage + 1
        print(currentPage)
        request.getUpcomingMovieList(page: currentPage){ [weak self]
            value,error in
            if let error = error {
                self?.errorThreatment(error: error)
            }
            
            if let value = value {
                var movies = self?.availableMovies.value
                movies?.append(contentsOf: value.movieList)
                self?.availableMovies.accept(movies ?? [])
                self?.currentPage = value.page
                self?.maxPages = value.totalPages
            }
        }
    }
    
    func errorThreatment(error: Error){
        self.errorMessageToDisplay.accept(error.localizedDescription)
    }
}
