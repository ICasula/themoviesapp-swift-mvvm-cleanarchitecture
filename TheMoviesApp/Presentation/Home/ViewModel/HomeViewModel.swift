//
//  HomeViewModel.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import RxSwift
import RxCocoa

class HomeViewModel : BaseViewModel {
    var router: HomeRouter
    
    private let popularMoviesUseCase: FetchPopularMoviesUseCase
    
    private var requestedPage = 0
    private(set) var moviesPage: MoviePage?
    private(set) var popularMovies = BehaviorRelay(value: [Movie]())
    private(set) var filteredPopularMovies = BehaviorRelay(value: [Movie]())

    init(router: HomeRouter, popularMoviesUseCase : FetchPopularMoviesUseCase) {
        self.router = router
        self.popularMoviesUseCase = popularMoviesUseCase
    }
    
    private let disposeBag = DisposeBag()
    
    func getPopularMovies() {
        var page = 1
        
        if let moviesPage = moviesPage {
            page = moviesPage.page + 1
            
            guard moviesPage.page < moviesPage.totalPages, requestedPage != page else { return }

            requestedPage = page
        }
        
        popularMoviesUseCase.execute(page: String(page))
        //Concurrencia
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        //Suscripción
            .subscribe(onNext: { moviesPage in
                self.requestedPage = 0
                self.moviesPage = moviesPage
                self.popularMovies.accept(self.popularMovies.value + moviesPage.movieList)
                self.filteredPopularMovies.accept(self.popularMovies.value + moviesPage.movieList)
            },
            onError: { error in
                self.requestedPage = 0
                print("Error popular movies: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func navigateToDetailView(movieID: String, from vc: UIViewController) {
        router.navigateToDetailView(movieID: movieID, from: vc)
    }
}
