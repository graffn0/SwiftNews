//
//  NewsManager.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

struct NewsManager {
    let key = "apiKey=68fe743bbc484531b7c6ebec520178a9"
    let baseURL = "https://newsapi.org/v2/everything?"
    
    enum apiError: Error {
        case error
    }
    
    func getNews() -> Observable<[News]> {
        let stringURL = "\(baseURL)q=privacy&\(key)"
        return request(.get, stringURL)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON()
            .map { response -> [News] in
                let decoder = JSONDecoder()
                switch response.result {
                case .success: do {
                    guard let data = response.data else { throw apiError.error }
                    let result = try decoder.decode(Root.self, from: data)
                    return result.articles
                } catch { print(error) }
                case .failure(let error): print(error)
                }
                
                let blank: [News] = []
                return blank
            }
            .observeOn(MainScheduler.instance)
    }
}
