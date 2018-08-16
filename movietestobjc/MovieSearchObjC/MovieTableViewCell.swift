//
//  MovieTableViewCell.swift
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    //
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //    }
    //    override func prepareForReuse() {
    //        moviePosterImage.image = nil
    //    }
    var movie: EPMovie? {
        didSet{
            updateMovie()
                
                    }
    }
    var movieImage: UIImage? {
        didSet {
            updateImage()
            
        }
    }
    func updateMovie() {
        guard let movie = movie else {return}
        DispatchQueue.main.async {
            
        
        self.movieTitleLabel.text = movie.title
        self.movieRatingLabel.text = "\(movie.rating)"
        self.movieSummaryLabel.text = movie.summary
        }
        
    }
    func updateImage() {
        guard let movieImage = movieImage else {return}
        DispatchQueue.main.async {
            
            self.moviePosterImage.image = movieImage
        }
    }
}
