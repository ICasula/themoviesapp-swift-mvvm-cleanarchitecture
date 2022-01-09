//
//  MovieDetailResponse.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import Foundation

struct MovieDetailResponseDTO : Codable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String?
    let homepage: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case homepage
        case voteAverage = "vote_average"
    }
}

extension MovieDetailResponseDTO {
    public func toDomain() -> MovieDetail {
        return MovieDetail(title: title,
                           posterPath: posterPath,
                           overview: overview,
                           releaseDate: releaseDate,
                           homepage: homepage,
                           voteAverage: voteAverage)
    }
}
