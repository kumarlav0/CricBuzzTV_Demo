//
//  MovieCellTableViewCell.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import UIKit
import Kingfisher

class MovieCellTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieLanguagesLbl: UILabel!
    @IBOutlet weak var movieReleaseDateLbl: UILabel!
    
    func setup(movie: Movie) {
        DispatchQueue.main.async { [weak self] in
            self?.moviePosterImageView.kf.setImage(with: movie.posterUrl, placeholder: UIImage(named: "Placeholder Image"))
        }
        movieTitleLbl.text =  movie.title
        movieLanguagesLbl.text = "Language: " + movie.language
        movieReleaseDateLbl.text = "Year: " + movie.year
    }

    
}
