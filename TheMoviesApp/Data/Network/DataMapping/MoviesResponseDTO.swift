//
//  Movie.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import Foundation

struct MoviesResponseDTO: Codable {
    let movieList : [MovieResponseDTO]
    let page: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case movieList = "results"
        case page
        case totalPages = "total_pages"
    }
}

struct MovieResponseDTO: Codable {
    public let title: String
    let popularity: Double
    let movieId: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case movieId = "id"
        case overview
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case imageURL = "poster_path"
    }
}

//MARK: - Mapping to Domain
extension MoviesResponseDTO {
    func toDomain() -> MoviePage {
        return MoviePage(movieList: movieList.map { $0.toDomain() },
                      page: page,
                      totalPages: totalPages)
        
    }
}

extension MovieResponseDTO {
    func toDomain() -> Movie {
        return Movie(title: title,
                     popularity: popularity,
                     movieId: movieId,
                     voteCount: voteCount,
                     originalTitle: originalTitle,
                     voteAverage: voteAverage,
                     overview: overview,
                     releaseDate: releaseDate,
                     imageURL: imageURL)
    }
}
