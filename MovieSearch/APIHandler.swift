//
//  APIHandler.swift
//  MovieSearch
//
//  Created by Nathan Chen on 6/19/17.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//
/*
 https://api.themoviedb.org/3/search/movie?api_key=fd7995a0d018c59d9076191bef81645c&language=en-US&query=a&page=1&include_adult=false */
import Foundation
import Alamofire
typealias completion = (_ movies : [MovieItem]) -> ()
class APIHandler{
    
   static var search_base_API = "https://api.themoviedb.org/3/search/movie?"
   static var discover_base_API = "https://api.themoviedb.org/3/discover/movie?api_key=fd7995a0d018c59d9076191bef81645c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
    static var api_key = "fd7995a0d018c59d9076191bef81645c"
    static var image_base_API = "https://image.tmdb.org/t/p/w342/"
    class func searchMovie(query:String,page:Int,comletion:@escaping completion){
        let queryURLStr = search_base_API + SearchParams.api_key.rawValue + "=\(api_key)&" + SearchParams.query.rawValue + "=\(query)&" + SearchParams.language.rawValue + "=en-US&" + SearchParams.page.rawValue + "=\(page)"
        Alamofire.request(queryURLStr).responseJSON { (dataResponse) in
            if dataResponse.error == nil{
                if let json = dataResponse.value as? [String:Any]{
                    if(json["errors"] == nil){
                        
                        if let movieArray = json["results"] as? [[String:Any]]{
                           let movies = movieArray.map({ (movieItemDict) -> MovieItem in
                            MovieItem(JSON: movieItemDict)!
                           })
                            comletion(movies)
                           
                        }
                    }
               
            }
        }
            else{
                print(dataResponse.error?.localizedDescription ?? "No error")
            }
        }
    }
    
    class func getImageURL(imagePath:String) -> URL? {
        let imageURLStr = image_base_API + imagePath
        let imageURL = URL(string: imageURLStr)
        return imageURL
    }
}
enum SearchParams:String {
    case api_key,language,query,page,include_adult
}
enum DiscoverParam:String {
    case api_key,language,sort_by,include_adult,include_video,page
}

