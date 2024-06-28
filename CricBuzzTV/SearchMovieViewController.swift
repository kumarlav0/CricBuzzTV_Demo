//
//  SearchMovieViewController.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchMovieListTableView: UITableView!
    
    lazy var viewModel = SearchViewModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMovieListTableView.registerCell(with: MovieCellTableViewCell.nameOfClass, identifier: MovieCellTableViewCell.nameOfClass)
        searchTF.delegate = self
        viewModel.delegate = self
        viewModel.showRandomMovies()
    }

}

extension SearchMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = searchMovieListTableView.dequeueReusableCell(withIdentifier: MovieCellTableViewCell.nameOfClass, for: indexPath) as? MovieCellTableViewCell else { return UITableViewCell() }
            let movie = viewModel.movies[indexPath.row]
            cell.setup(movie: movie)
            return cell
    }
}

extension SearchMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: MovieDetailsViewController.nameOfClass) as? MovieDetailsViewController else { return }
        detailsVC.movie = viewModel.movies[indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension SearchMovieViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        viewModel.filterMovies(with: newText)
        return true
    }
}

extension SearchMovieViewController: SearchViewModelsDelegate {
    func didUpdateList() {
        searchMovieListTableView.reloadDataInMainQueue()
    }
}
