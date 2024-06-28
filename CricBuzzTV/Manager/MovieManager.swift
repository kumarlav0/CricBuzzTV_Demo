//
//  MoviesViewModel.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import Foundation

enum MovieGroup: String, CaseIterable {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
    
    var name: String {
        rawValue
    }
}

class MovieManager {
    static let shared = MovieManager()
    private init() {
        getAllMovies()
    }
    
    var allMovies = [Movie]()
    var allTypes = MovieGroup.allCases
    
    private var uniqueYears: [String] {
        let years = allMovies.map { $0.year }
        return Array(Set(years)).sorted()
    }
    
    private var uniqueGenres: [String] {
        let genres = allMovies.flatMap { $0.genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        return Array(Set(genres)).sorted()
    }
    
    private var uniqueDirectors: [String] {
        let directors = allMovies.map { $0.director }
        return Array(Set(directors)).sorted()
    }
    
    private var uniqueActors: [String] {
        let actors = allMovies.flatMap { $0.actors.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        return Array(Set(actors)).sorted()
    }
}

extension MovieManager {
    func getAllMovies() {
        if let movies = JSONLoader.loadMovies(from: .movie) {
            print("Total: ",movies.count)
            allMovies = movies
        } else {
            print("Failed to load movies.")
        }

    }
}

extension MovieManager {

    private func movies(forYear year: String) -> [Movie] {
        allMovies.filter { $0.year == year }
    }

    private func movies(forGenre genre: String) -> [Movie] {
        allMovies.filter { $0.genre.contains(genre) }
    }

    private func movies(forDirector director: String) -> [Movie] {
        allMovies.filter { $0.director == director }
    }

    private func movies(forActor actor: String) -> [Movie] {
        allMovies.filter { $0.actors.contains(actor) }
    }
    
    func getMovie(byType type: MovieGroup) -> [Movie] {
        switch type {
        case .actors:
            return movies(forActor: type.name)
        case .directors:
            return movies(forDirector: type.name)
        case .genre:
            return movies(forGenre: type.name)
        case .year:
            return movies(forYear: type.name)
        case .allMovies:
            return allMovies
        }
    }
    
    func getCategoryData(byType type: MovieGroup) -> [String] {
        switch type {
        case .actors:
            return uniqueActors
        case .directors:
            return uniqueDirectors
        case .genre:
            return uniqueGenres
        case .year:
            return uniqueYears
        case .allMovies:
            return []
        }
    }

    func searchMovies(query: String) -> [Movie] {
        return allMovies.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.genre.localizedCaseInsensitiveContains(query) ||
            $0.actors.localizedCaseInsensitiveContains(query) ||
            $0.director.localizedCaseInsensitiveContains(query)
        }
    }
}
