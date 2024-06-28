//
//  MovieDetailsViewController.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var languagesLb: UILabel!
    
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var generLbl: UILabel!
    @IBOutlet weak var actorLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            
            DispatchQueue.main.async { [weak self] in
                self?.posterImgView.kf.setImage(with: movie.posterUrl, placeholder: UIImage(named: "Placeholder Image"))
            }
            
            titleLbl.text = movie.title
            languagesLb.text = "Lang: " + movie.language
            
            
            yearLbl.text = "Release: " + movie.released
            generLbl.text = "Gener: " + movie.genre
            actorLbl.text = "Cast: " + movie.actors
            durationLbl.text = "Duration: " + movie.runtime
            descriptionLbl.text = """
Writer: \(movie.writer)

Director: \(movie.director)

BoxOffice Collection: \(movie.boxOffice ?? "N/A")

Production: \(movie.production ?? "N/A")

Awards: \(movie.awards ?? "N/A")
"""
            
        }
    }
    
}
