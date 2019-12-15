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
    
    func routeToUpcomingMovies(){
        
        
    }
    
    func addViewControllerToNavigation(vc : UIViewController){
        navigationController.addChild(vc)
    }
    
}
