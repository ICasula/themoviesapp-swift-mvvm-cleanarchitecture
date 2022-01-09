//
//  MovieDBRepository.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import Foundation

class MovieDBRepository {
    static let apiKey = "?api_key=7f45a2aac87eb736933594a883984ebc"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imagesURL = "https://image.tmdb.org/t/p/w200"
    static let page = "&page="
    
    struct Endpoints {
        static let urlListMovies = "movie/popular"
        static let urlMovieDetail = "movie/"
    }
}
