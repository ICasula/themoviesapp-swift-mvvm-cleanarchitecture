//
//  DetailViewModel.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 04/01/2022.
//

import Foundation
import RxSwift

class DetailViewModel {
    private let useCase : FetchMovieDetailsUseCase
    private let movieID: String
    
    init(movieID:String, useCase: FetchMovieDetailsUseCase) {
        self.movieID = movieID
        self.useCase = useCase
    }
    
    func getMovieData() -> Observable<MovieDetail> {
        return useCase.execute(movieID: movieID)
    }
}
