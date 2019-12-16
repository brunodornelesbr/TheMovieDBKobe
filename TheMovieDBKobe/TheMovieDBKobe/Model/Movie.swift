//
//  Movie.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import ObjectMapper

class Movie: Mappable {
    
    var id  = -1
    var original_title = ""
    var posterPath : String?
    var backdropPath : String?
    var genres = ""
    var releaseDate : Date?
    var overview = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        original_title <- map["original_title"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        overview <- map["overview"]
        var genreIds = [Int]()
        genreIds <- map["genre_ids"]
      
        for id in genreIds {
            genres.append(contentsOf:"\n\(Genres.getGenre(id: id))")
        }
        var release = ""
        release<-map["release_date"]
        releaseDate = DateFormatter.formatFromAPI(string: release)
    }
    
    func getPosterURL()->URL?{
        guard let path = posterPath else {return nil}
        let urlString = String(format:APIConstants.imageUrl,path)
        
        return URL(string: urlString)
    }
    
}
