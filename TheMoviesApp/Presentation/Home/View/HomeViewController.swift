//
//  HomeViewController.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 03/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    public var viewModel : HomeViewModel?
    private let disposeBag = DisposeBag()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar..."
        
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Películas populares"
        configureSearchBar()
        configureTableView()
        getData()
    }
    
    private func configureTableView() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.rowHeight = 200
        self.tableView.register(UINib(nibName: "CustomMovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
    }
    
    private func configureSearchBar() {
        let searchBar = searchController.searchBar
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { (text) in
                
                guard let viewModel = self.viewModel else { return }
                viewModel.filteredPopularMovies.accept(viewModel.popularMovies.value.filter({
                    movie in
                    return text.isEmpty ? true : movie.title.contains(text)
                }))
            }).disposed(by: disposeBag)
    }
    
    private func getData() {
        viewModel?.filteredPopularMovies
        //Concurrencia
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        //Suscripción
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: CustomMovieTableViewCell.self)) {
                row, model, cell in
                
                cell.lblTitle.text = model.title
                cell.lblOverview.text = model.overview
                cell.imgPoster.imageFromURL(urlString: MovieDBRepository.imagesURL + model.imageURL, placeholderImage: nil)
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Movie.self).bind {
            movie in
            
            self.viewModel?.navigateToDetailView(movieID: String(movie.movieId), from: self)
        }.disposed(by: disposeBag)
        
        tableView.rx.didScroll.skip(1).subscribe { [weak self] _ in
                    guard let self = self else { return }
                    let offSetY = self.tableView.contentOffset.y
                    let contentHeight = self.tableView.contentSize.height

                    if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                        self.viewModel?.getPopularMovies()
                    }
                }
                .disposed(by: disposeBag)
        
        //Fetch popular movies
        //viewModel?.getPopularMovies()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else  { return }
            viewModel.filteredPopularMovies.accept(viewModel.popularMovies.value)
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
