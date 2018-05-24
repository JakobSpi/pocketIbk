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

enum ApiError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case noData(Error?)
    case invalidJson
}

enum ApiResult<T, E: Error> {
    case success(T)
    case failure(E)
}
class Api {
    func getTodayProgram(completion: @escaping((ApiResult<[String: Any], ApiError>)) -> Void) {
        let provider = MoyaProvider<MovieService>()
        provider.request(.today) { result in
            var resultJSON: ApiResult<[String: Any], ApiError>
            switch result {
            case let .success(moyaResponse):
                guard let jsonObject = try? JSONSerialization.jsonObject(with: moyaResponse.data,
                                                                         options: .allowFragments) else {
                    resultJSON = .failure(.invalidJson)
                    return
                }
                var json: [String: Any]?
                if let jsonArray = jsonObject as? [[String: Any]] {
                    json = ["data": jsonArray]
                } else if let jsonDictionary = jsonObject as? [String: Any] {
                    json = jsonDictionary
                }
                if let json = json {
                    resultJSON = .success(json)
                } else {
                    resultJSON = .failure(.invalidJson)
                }
                completion(resultJSON)
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
