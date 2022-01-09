//
//  DetailViewController.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 04/01/2022.
//

import UIKit
import RxSwift

class DetailViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    
    var viewModel : DetailViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData() {
        viewModel?.getMovieData().subscribe(
            onNext: { movie in
                self.showMovieData(movie: movie)
            },
            onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.lblTitle.text = movie.title
            self.imgPoster.imageFromURL(urlString: MovieDBRepository.imagesURL + movie.posterPath, placeholderImage: nil)
            self.lblOverview.text = movie.overview
        }
    }
}
