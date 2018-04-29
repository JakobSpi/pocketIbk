//
//  MainTableViewController.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    
    var getData = GetData()
    var todayProgram = [TodayObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData.getTodayProgram{ (programJSON) in
            
            //let todayJSONObject = programJSON
            
            
            if programJSON.count > 0{
                self.setData(data: programJSON)
                //self.todayProgramJSON = programJSON
                self.tableView.reloadData()
            }
            
        }
    }
    
    func setData(data: [TodayJSONObject]){
        var i = 0
        for movieJSON in data{
            
            let movie = TodayObject(_theaterId: movieJSON.theaterId, _theaterName: movieJSON.theaterName, _movieId: movieJSON.movieId, _movieTitle: movieJSON.movieTitle, _movieGenre: movieJSON.movieGenre, _movieRating: movieJSON.movieRating, _movieInfo: movieJSON.info)
            todayProgram.append(movie)
            
            self.downloadImages(_movie: todayProgram[i], _i: i)
            self.tableView.reloadData()
            i = i+1
        }
        
        
    }
    
    func setImage(image: UIImage, i: Int){
        
        todayProgram[i].movieImage = image
        self.tableView.reloadData()
        
    }
    
    func downloadImages( _movie: TodayObject, _i: Int){
        
        let allowedCharacterSer = (CharacterSet(charactersIn: "!§$%&/()=?`¡“¶¢[]|{}≠¿ -.,;:_").inverted)
        let escapedTextForUrl = _movie.movieTitle.addingPercentEncoding(withAllowedCharacters: allowedCharacterSer)
        print(escapedTextForUrl)
        let width = UIScreen.main.nativeScale*90
        let height = UIScreen.main.nativeScale*120
        let url = "https://dummyimage.com/\(width)x/\(height)/000000/ffffff.png?text=\(escapedTextForUrl!)"
        
        print(url)
        self.getData.downloadImage(url: URL(string: url)!, i: _i, completion: { (image, i) in
            self.setImage(image: image, i: i)
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "maintvcell", for: indexPath) as! MainTableViewCell
        
        if(todayProgram).count > 0{
            
            cell.movieTitle.text = todayProgram[indexPath.row].movieTitle
//            cell.movieTitle.adjustsFontSizeToFitWidth = true
            cell.movieGenre.text = todayProgram[indexPath.row].movieGenre
            cell.movieInfo.text = todayProgram[indexPath.row].info
            cell.cinemaDestAndTime.text = "dest and time"//todayProgram[indexPath.row].
            cell.movieImage.image = todayProgram[indexPath.row].movieImage
        }
        
        
        
        return cell
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
