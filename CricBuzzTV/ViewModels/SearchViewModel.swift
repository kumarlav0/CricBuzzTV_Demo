//
//  SearchViewModel.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import Foundation

protocol SearchViewModelsDelegate: AnyObject {
    func didUpdateList()
}

class SearchViewModels {
    var movies = [Movie]()
    weak var delegate: SearchViewModelsDelegate?
    var filterType: MovieGroup?
    var filterKeyword: String?
    
    func showRandomMovies() {
        movies = MovieManager.shared.allMovies
        
        if let filterType = filterType, let filterKeyword = filterKeyword {
            switch filterType {
            case .actors:
                movies = movies.filter { $0.actors.contains(filterKeyword) }
            case .directors:
                movies = movies.filter { $0.director.contains(filterKeyword) }
            case .genre:
                movies = movies.filter{ $0.genre.contains(filterKeyword) }
            case .year:
                movies = movies.filter { $0.year.contains(filterKeyword) }
            case .allMovies:
                movies = MovieManager.shared.allMovies
            }
        }
        delegate?.didUpdateList()
    }
    
    func filterMovies(with searchText: String) {
        guard !searchText.isEmpty else {
            showRandomMovies()
            return
        }
        movies =  MovieManager.shared.searchMovies(query: searchText)
        delegate?.didUpdateList()
    }

}
