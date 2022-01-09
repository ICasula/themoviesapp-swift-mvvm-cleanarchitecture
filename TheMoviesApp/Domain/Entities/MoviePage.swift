//
//  Movie.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import Foundation

struct MoviePage {
    let movieList : [Movie]
    let page: Int
    let totalPages: Int
}

struct Movie {
    let title: String
    let popularity: Double
    let movieId: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let imageURL: String
}
