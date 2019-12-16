//
//  Request.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class Request {

    func getUpcomingMovieList(page : Int = 1,completionHandler : @escaping (UpcomingMoviesRequestObject?,Error?)->()) {
        let url =  APIConstants.upcomingMoviesUrl
        let params : Parameters = ["page":page,"api_key":APIConstants.apikey]
        Alamofire.request(url, method: .get, parameters: params, headers:nil).validate().responseObject{ (response:DataResponse<UpcomingMoviesRequestObject>) in
            switch response.result {
            case .success(let upcomingObject): completionHandler(upcomingObject,nil)
                return
            case .failure(let error):
                completionHandler(nil,error)
            }
        }
    }
    
    func searchForMovie(query : String,page : Int = 1, completionHandler : @escaping (UpcomingMoviesRequestObject?,Error?)->()) {
        let url = APIConstants.searchMovie
        let params : Parameters = ["page":page,"api_key":APIConstants.apikey,"query" : query]
       
        Alamofire.request(url, method: .get, parameters: params, headers:nil).validate().responseObject{ (response:DataResponse<UpcomingMoviesRequestObject>) in
                   switch response.result {
                   case .success(let upcomingObject): completionHandler(upcomingObject,nil)
                       return
                   case .failure(let error):
                       completionHandler(nil,error)
                   }
       }
    }
    
    func getGenres(completionHandler : @escaping (Bool?,Error?)->()) {
        let url = APIConstants.genreList
        let params : Parameters = ["api_key":APIConstants.apikey]
        
        Alamofire.request(url, method: .get, parameters: params, headers:nil).validate().responseObject{ (response:DataResponse<Genres>) in
                          switch response.result {
                          case .success(let genresList): completionHandler(true,nil)
                              return
                          case .failure(let error):
                              completionHandler(false,error)
                          }
              }
    }
}
