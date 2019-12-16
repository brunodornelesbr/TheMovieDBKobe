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
    var request = Request()
    init(){
        navigationController = UINavigationController()
        routeToUpcomingMovies()
    }
    //MARK:- Routing methods
    func routeToUpcomingMovies() {
        let upcomingMovie = instantiateInitialVCFromStoryboard(storyboardName: "UpcomingMovies") as! UpcomingMoviesViewController
        upcomingMovie.model = UpcomingMovieViewModel(request: request, router: self)
        addViewControllerToNavigation(vc: upcomingMovie)
    }
    func routeToDetailsMovie(movie : Movie) {
//           let detailsMovie = instantiateInitialVCFromStoryboard(storyboardName: "DetailsMovie")
//           addViewControllerToNavigation(vc: detailsMovie)
       }
    
    //MARK:- Helper methods
    func addViewControllerToNavigation(vc : UIViewController) {
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func instantiateInitialVCFromStoryboard(storyboardName : String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        guard let existingVc = vc else {fatalError("Initial view controller not set in storyboard \(storyboardName)")
        }
        return existingVc
    }
}
