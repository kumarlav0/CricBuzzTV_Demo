//
//  MoviesViewModel.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import Foundation

protocol MoviesViewModelDelegate: AnyObject {
    func didReloadData()
}

class MoviesViewModel {
    weak var delegate: MoviesViewModelDelegate?
    
    var allCategory: [MovieGroup] {
        MovieManager.shared.allTypes
    }
    
    var allGroup = [any Group]()
}

extension MoviesViewModel {
    func createGroup() {
        for category in allCategory {
            if category != .allMovies {
                let items = MovieManager.shared.getCategoryData(byType: category)
                let grp = NonMediaGroup(listItems: items, title: category, isExpanded: false)
                allGroup.append(grp)
            } else {
                let items = MovieManager.shared.getMovie(byType: category)
                let grp = MediaGroup(listItems: items, title: category, isExpanded: false)
                allGroup.append(grp)
            }
        }
        delegate?.didReloadData()
    }
    
    func didExpand(section: Int) {
        allGroup[section].isExpanded.toggle()
        delegate?.didReloadData()
    }
}
