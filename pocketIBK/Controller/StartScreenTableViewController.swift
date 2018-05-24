//
//  MainTableViewController.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class StartScreenTableViewController: UITableViewController {
    let api = Api()
    var todayProgram = [TodayObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getTodayProgram { [weak self] result in
            switch result {
            case .success(let json):
                guard let movieJsons = json["data"] as? [[String: Any]] else {
                    return
                }
                self?.todayProgram = movieJsons.compactMap { TodayObject(json: $0) }
                self?.downloadImages()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    func downloadImages() {
        for counter in 0..<todayProgram.count {
            downloadImages(movie: todayProgram[counter], counter: counter)
        }
    }
    func setImage(image: UIImage, counter: Int) {
        todayProgram[counter].setImage(image: image)
        let indexPath = IndexPath(item: counter, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todayProgram.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "maintvcell", for: indexPath)
            as? MainTableViewCell {
            guard !todayProgram.isEmpty else {
                return cell
            }
            cell.todayProgram = todayProgram[indexPath.row]
            return cell
        }
        // just for now until extensions work
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "maintvcell", for: indexPath) as UITableViewCell
            return cell
        }
        /* Alternative with extension
         let cell = tableView.dequeReusableCell(withClass: MainTableViewCell.self, forIndexPath: indexPath) {
         
         }
         */
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
extension StartScreenTableViewController {
    func downloadImages(movie: TodayObject, counter: Int) {
        let width = UIScreen.main.nativeScale*90
        let height = UIScreen.main.nativeScale*120
        let backgroundColor = "000000"
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
