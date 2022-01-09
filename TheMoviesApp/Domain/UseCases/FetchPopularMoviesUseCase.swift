//
//  FetchPopularMoviesUseCase.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import RxSwift

protocol FetchPopularMoviesUseCase {
    func execute(page: String) -> Observable<MoviePage>
}

final class MovieDBFetchPopularMoviesUseCase : FetchPopularMoviesUseCase {
    
    private let popularMoviesRepository: PopularMoviesRepository
    
    init(repository: PopularMoviesRepository) {
        self.popularMoviesRepository = repository
    }
    
    func execute(page: String) -> Observable<MoviePage> {
        return popularMoviesRepository.getPopularMovies(page: page)
    }
}
