//
//  GetData.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import ObjectMapper

protocol DownloadPictureDelegate: class {
    func reloadTv(image: UIImage)
}
class GetData{
    
    weak var delegate: DownloadPictureDelegate?
    
    func getTodayProgram(completion: @escaping([TodayJSONObject]) -> Void) {
        
        var todayProgram = [TodayJSONObject]()
        
        let provider = MoyaProvider<MoyaService>()
        provider.request(.today) { result in
            switch result {
            case let .success(_moyaResponse):
                do{
                    let _today =  try! JSONDecoder().decode([TodayJSONObject].self, from: _moyaResponse.data)
                    
                    todayProgram = _today
                    
                    completion(todayProgram)
                }
                catch let error as NSError{
                    
                    print("no json available!")
                    completion(todayProgram)
                }
                
                
                
            case let .failure(error):
                
                print("FAIL = \(error)")
                
            }
            
            
        }
        
        
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, i: Int, completion: @escaping (UIImage, Int) -> ()) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            print(i)
            DispatchQueue.main.async() {
                completion(UIImage(data: data)!, i)
            }
        }
    }
    
    
}


