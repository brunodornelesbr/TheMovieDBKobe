//
//  Router.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 14/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

class Router {
    var navigationController : UINavigationController
    init(){
        navigationController = UINavigationController()
        routeToUpcomingMovies()
    }
    //MARK:- Routing methods
    func routeToUpcomingMovies() {
        let upcomingMovie = instantiateInitialVCFromStoryboard(storyboardName: "UpcomingMovies") as! UpcomingMoviesViewController
        upcomingMovie.model = UpcomingMovieViewModel()
        addViewControllerToNavigation(vc: upcomingMovie)
    }
    
    //MARK:- Helper methods
    func addViewControllerToNavigation(vc : UIViewController) {
        navigationController.addChild(vc)
    }
    
    func instantiateInitialVCFromStoryboard(storyboardName : String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        guard let existingVc = vc else {fatalError("Initial view controller not set in storyboard \(storyboardName)")
        }
        return existingVc
    }
}
