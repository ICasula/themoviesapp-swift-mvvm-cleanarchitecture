//
//  MovieDBPopularMoviesRepository.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import RxSwift

final class MovieDBPopularMoviesRepository {

}

extension MovieDBPopularMoviesRepository : PopularMoviesRepository {
    func getPopularMovies(page: String) -> Observable<MoviePage> {
        return Observable.create { observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: MovieDBRepository.baseURL + MovieDBRepository.Endpoints.urlListMovies + MovieDBRepository.apiKey + MovieDBRepository.page + page)!)
            
            print("Requesting: \(request)")
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) {
                (data, response, error) in
                
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(MoviesResponseDTO.self, from: data)
                        
                        observer.onNext(movies.toDomain())
                    } catch let error {
                        observer.onError(error)
                    }
                } else {
                    print("Error status code: \(response.statusCode)")

                }
                
                observer.onCompleted()
            }.resume()
            
            return Disposables.create {
                //session.finishTasksAndInvalidate()
            }
        }
    }
    
    
}
