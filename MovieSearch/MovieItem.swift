//
//  File.swift
//  MovieSearch
//
//  Created by Nathan Chen on 6/19/17.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//
/*
 vote_count:103
 id:23367
 video:false
 vote_average:5.5
 title:Bandslam
 popularity:2.078005
 poster_path:/kxCxlaYADkiXCzCDneWcZ0oABqU.jpg
 original_language:en
 original_title:Bandslam
 genre_ids4 Items
 backdrop_path:/zkMj4qCtgAz614vp8lcLg7sPosP.jpg
 adult:false
 overview:A high school social outcast and the popular girl bond through a shared love of music.
 release_date:2009-08-06
 */

import Foundation
import ObjectMapper

class MovieItem:Mappable{
    var title:String?
    var poster_path:String?
    var overview:String?
    var release_date:String?
    required init?(map: Map) {
        
       }
    
    func mapping(map: Map) {
    title <- map["title"]
    poster_path <- map["poster_path"]
    overview  <- map["overview"]
    release_date <- map["release_date"]
    }
}
