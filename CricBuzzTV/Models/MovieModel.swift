//
//  MovieModel.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import Foundation

protocol Group {
    associatedtype Item
    
    var listItems: [Item] { get }
    var title: MovieGroup { get }
    var isExpanded: Bool { get set }
}


struct NonMediaGroup: Group  {
    typealias Item = String

    var listItems: [Item]
    var title: MovieGroup
    var isExpanded: Bool
}


struct MediaGroup: Group {
    
    typealias Item = Movie

    var listItems: [Item]
    var title: MovieGroup
    var isExpanded: Bool
}

struct Movie: Codable {
    let title: String
    let year: String
    let rated: String?
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String?
    let poster: String?
    let ratings: [Rating]
    let metascore: String?
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String
    
    var posterUrl: URL? {
        URL(string: poster ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating
        case imdbVotes
        case imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

struct Rating: Codable {
    let source: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

class JSONLoader {
    static func loadMovies(from file: MovieJsonFile) -> [Movie]? {
        guard let url = Bundle.main.url(forResource: file.name, withExtension: "json") else {
            print("Failed to locate \(file.name).json in bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to load or decode \(file.name).json: \(error)")
            return nil
        }
    }
}

enum MovieJsonFile: String {
    case movie = "movies"
    
    var name: String {
        rawValue
    }
}
