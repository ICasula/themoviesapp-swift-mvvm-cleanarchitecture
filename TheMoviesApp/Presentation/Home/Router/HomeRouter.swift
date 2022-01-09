//
//  HomeRouter.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import UIKit

class HomeRouter : BaseRouter {    
    func navigateToDetailView(movieID: String, from vc:UIViewController) {
        
        let viewController = DetailViewController.storyboardInstance()
        
        let viewModel = DetailViewModel(
            movieID: movieID,
            useCase: MovieDBFetchMovieDetailsUseCase(
                repository: MovieDBMovieDetailsRepository()
            )
        )
        viewController.viewModel = viewModel
        
        vc.navigationController?.pushViewController(viewController, animated: true)
    }
}
