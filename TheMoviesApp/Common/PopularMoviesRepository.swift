//
//  PopularMoviesRepository.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import RxSwift

protocol PopularMoviesRepository {
    func getPopularMovies(page: String) -> Observable<MoviePage>
}
