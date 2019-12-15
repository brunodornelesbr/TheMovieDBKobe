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
class UpcomingMovieViewModel {

   private var availableMovies = BehaviorRelay<[Movie]>(value : [Movie(),Movie(),Movie()])
    var movies : Observable<[Movie]> {return availableMovies.asObservable()}
    
}
