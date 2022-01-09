//
//  FetchPopularMoviesUseCase.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import RxSwift

protocol FetchMovieDetailsUseCase {
    func execute(movieID: String) -> Observable<MovieDetail>
}

final class MovieDBFetchMovieDetailsUseCase : FetchMovieDetailsUseCase {
    
    private let repository: MovieDetailsRepository
    
    init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    func execute(movieID: String) -> Observable<MovieDetail> {
        return repository.getMovieDetail(movieID: movieID)
    }
}
