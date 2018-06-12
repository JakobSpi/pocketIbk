//
//  DetailViewController.swift
//  pocketIBK
//
//  Created by Jakob Spirk on 02.06.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let api = Api()
    var movieId = ""
    var movieDetails: MovieObject?
    var movieChoice: TodayObject?
    @IBOutlet weak var timeAndCinemaHeaderLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieCountryAndYear: UILabel!
    @IBOutlet weak var movieIMDBRating: UILabel!
    @IBOutlet weak var movieRegie: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let choice = movieChoice else {
            return
        }
        print(choice.id)
        api.getMovieDetail(id: choice.id) { [weak self] result in
            switch result {
            case .success(let json):
                self?.movieDetails = MovieObject(json: json)
                self?.initUI()
            case .failure(let error):
                print(error)
                self?.showAlert(title: "You are not connected to the internet!",
                                message: "Please connect to the internet.")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
        }
    }
    func initUI() {
        guard let choice = movieChoice else {
            return
        }
        guard let details = movieDetails else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeAndCinemaHeaderLabel.text = dateFormatter.string(from: choice.time) + " Uhr " + choice.theaterName
        movieImage.image = choice.image
        movieTitle.text = choice.title
        movieGenre.text = choice.genre
        movieDuration.text =  String(details.duration/60000) + " Minutes"
        movieCountryAndYear.text = details.land + " " + details.year
        movieIMDBRating.text = "IMDB Rating: " + details.rating + "/10"
        movieRegie.text = details.director
        movieActors.text = details.actors
        movieDescription.text = details.description
    }
}
