//
//  ViewController.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesTableView.registerHeaderView(with: MovieListHeaderView.nameOfClass, identifier: MovieListHeaderView.nameOfClass)
        moviesTableView.registerCell(with: MovieCellTableViewCell.nameOfClass, identifier: MovieCellTableViewCell.nameOfClass)
        viewModel.delegate = self
        viewModel.createGroup()
    }
    
    @IBAction func didClickSearchAction(_ sender: UIBarButtonItem) {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: SearchMovieViewController.nameOfClass) as? SearchMovieViewController else { return }
        
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.allGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.allGroup[section].isExpanded {
            return viewModel.allGroup[section].listItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type =  viewModel.allGroup[indexPath.section].title
       
        
        if type != .allMovies {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let groupItem = viewModel.allGroup[indexPath.section].listItems[indexPath.row] as! String
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = groupItem
            return cell
        } else {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: MovieCellTableViewCell.nameOfClass, for: indexPath) as? MovieCellTableViewCell else { return UITableViewCell() }
            let groupItem = viewModel.allGroup[indexPath.section].listItems[indexPath.row] as! Movie
            cell.setup(movie: groupItem)
            return cell
        }
    }
    
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieListHeaderView.nameOfClass) as? MovieListHeaderView else { return UIView() }
        view.setData(title: viewModel.allGroup[section].title.name, section: section, isExpand: viewModel.allGroup[section].isExpanded)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type =  viewModel.allGroup[indexPath.section].title
        
        if type == .allMovies {
            guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: MovieDetailsViewController.nameOfClass) as? MovieDetailsViewController else { return }
            detailsVC.movie = viewModel.allGroup[indexPath.section].listItems[indexPath.row] as? Movie
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            guard let searchVC = storyboard?.instantiateViewController(withIdentifier: SearchMovieViewController.nameOfClass) as? SearchMovieViewController else { return }
            let groupItem = viewModel.allGroup[indexPath.section].listItems[indexPath.row] as! String
            searchVC.viewModel.filterType = type
            searchVC.viewModel.filterKeyword = groupItem
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func didReloadData() {
        moviesTableView.reloadDataInMainQueue()
    }
}

extension MoviesViewController: MovieListHeaderViewDelegate {
    func didClickedHeader(section: Int) {
        viewModel.didExpand(section: section)
    }
}
