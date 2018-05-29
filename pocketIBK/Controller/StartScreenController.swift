//
//  StartScreenController.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class StartScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let api = Api()
    var todayProgram = [TodayObject]()
    var todayProgramSorted = [[TodayObject]]()
    var alreadyDownloadedPicturesFromMovie = [String: UIImage]()
    var completeMovieObjects = 0
    var headerImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        headerImage = UIImage(named: "cinema.jpg")
        if self.checkInternetConnection() {
            api.getTodayProgram { [weak self] result in
                switch result {
                case .success(let json):
                    guard let movieJsons = json["data"] as? [[String: Any]] else {
                        return
                    }
                    self?.todayProgram = movieJsons.compactMap { TodayObject(json: $0) }
                    self?.downloadImages()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func downloadImages() {
        for counter in 0..<todayProgram.count {
            if alreadyDownloadedPicturesFromMovie.isEmpty {
                downloadImages(movie: todayProgram[counter], counter: counter)
            } else {
                if let _ = alreadyDownloadedPicturesFromMovie[todayProgram[counter].title] {
                    todayProgram[counter].image = alreadyDownloadedPicturesFromMovie[todayProgram[counter].title]
                } else {
                    downloadImages(movie: todayProgram[counter], counter: counter)
                }
            }
        }
    }
    func setImage(image: UIImage, counter: Int) {
        todayProgram[counter].setImage(image: image)
        alreadyDownloadedPicturesFromMovie[todayProgram[counter].title] = image
        completeMovieObjects += 1
        if todayProgram.count == completeMovieObjects {
            sortProgram()
        }
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayProgramSorted.count + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headertvcell", for: indexPath)
                as? HeaderTableViewCell {
                guard let headerImage = headerImage else {
                    return cell
                }
                let headerModel = HeaderTableViewModel(image: headerImage, labelText: "CinemaGuide")
                cell.headerModel = headerModel
                return cell
            }
                // just for now until extensions work
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "maintvcell",
                                                         for: indexPath) as UITableViewCell
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "maintvcell", for: indexPath)
            cell.backgroundColor = UIColor.orange
            return cell
        }
        /* Alternative with extension
         let cell = tableView.dequeReusableCell(withClass: MainTableViewCell.self, forIndexPath: indexPath) {
         
         }
         */
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else {
            return
        }
        print("tag: ")
        print(indexPath.row)
        tableViewCell.setCollectionViewDelegate(dataSource: self, delegate: self, forRow: indexPath.row)
    }
    func checkInternetConnection() -> Bool {
        if InternetConnection.isConnectedToNetwork() {
            return true
        } else {
            showAlert(title: "You are not connected to the internet!",
                      message: "Please connect to the internet.")
            print("not connected to the internet!")
            return false
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
        }
    }
    func sortProgram() {
        // still looking for a efficient sorting algorithm
        for counter in 0..<todayProgram.count {
            if todayProgramSorted.isEmpty {
                todayProgramSorted.append([todayProgram[counter]])
            } else {
                for counterSec in 0..<todayProgramSorted.count {
                    print(todayProgramSorted[counterSec][0].title + " & " + todayProgram[counter].title)
                    if todayProgramSorted[counterSec][0].title == todayProgram[counter].title {
                        todayProgramSorted[counterSec].append(todayProgram[counter])
                        print("true")
                        break
                    } else if counterSec == (todayProgramSorted.count - 1) {
                        todayProgramSorted.append([todayProgram[counter]])
                        print("added on back")
                    }
                }
            }
        }
        print("sorted")
        tableView.reloadData()
    }
}

/*extension UITableView {
    public func register<T: UITableViewCell>(cellClass `class`: T.Type) {
        registerClass(`class`, forCellReuseIfentifier: `class`.defaultIdentifier())
    }
    public func register<T: UITableViewCell>(nib: UINib, forClass `class`: T.Type) {
        registerNib(nib, forCellReuseIdentifier: `class`.defaultIdentifier())
    }
}*/
extension StartScreenController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        return todayProgramSorted[collectionView.tag - 2].count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "maincvcell", for: indexPath)
            as? MainCollectionViewCell {
            guard !todayProgramSorted.isEmpty else {
                return cell
            }
            cell.todayProgram = todayProgramSorted[collectionView.tag - 2][indexPath.row]
            cell.pageControl.numberOfPages = todayProgramSorted[collectionView.tag - 2].count
            cell.pageControl.currentPage = indexPath.row
            return cell
        }
            // just for now until extensions work
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "maintvcell",
                                                          for: indexPath) as UICollectionViewCell
            cell.backgroundColor = UIColor.orange
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    func downloadImages(movie: TodayObject, counter: Int) {
        let width = UIScreen.main.nativeScale*90
        let height = UIScreen.main.nativeScale*120
        let backgroundColor = "ffa500"
        let foregroundColor = "ffffff"
        let urlComponents = URLComponents.init(resolutionWidth: width, resolutionHeight: height,
                                               backgroundColor: backgroundColor, foregroundColor: foregroundColor,
                                               movieText: movie.title)
        let url = urlComponents.getEscapedUrl()
        print(url)
        self.api.downloadImage(url: URL(string: url)!, counter: counter, completion: { [weak self] (image, counter) in
            self?.setImage(image: image, counter: counter)
        })
    }
}
