//
//  MovieTableViewController.swift
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EPMovieController.shared().movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        let movie = EPMovieController.shared().movies[indexPath.row] as? EPMovie
        cell.movie = movie
        guard let unwrappedMovie = movie else { return UITableViewCell() }
       
        EPMovieController.shared().getMovieImage(from: unwrappedMovie) { (image) in
            DispatchQueue.main.async {
                
            
            cell.movieImage = image
            }
        }
        return cell
    }
}

extension MovieTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text, !searchTerm.isEmpty else {return}
        searchBar.text = ""
        searchBar.resignFirstResponder()
    
        EPMovieController.shared().getMovieWith(searchTerm) { (success) in
            if success == true {
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        }
    }
}
