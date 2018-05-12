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

class Api {
    func getTodayProgram(completion: @escaping([TodayJSONObject]) -> Void) {
        var todayProgram = [TodayJSONObject]()
        let provider = MoyaProvider<MovieService>()
        provider.request(.today) { result in
            switch result {
            case let .success(moyaResponse):
                    guard let today =  try? JSONDecoder().decode([TodayJSONObject].self, from: moyaResponse.data) else {
                        return
                    }
                    todayProgram = today
                    completion(todayProgram)
            case let .failure(error):
                print("FAIL = \(error)")
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL, counter: Int, completion: @escaping (UIImage, Int) -> Void) {
        print("Download Started")
        getDataFromUrl(url: url) { data, _, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image, counter)
            }
        }
    }
}
