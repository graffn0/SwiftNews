//
//  MainViewModel.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import Foundation
import RxSwift

struct MainViewModel {
    var newsList: Variable<[News]> = Variable.init([])
    let disposeBag = DisposeBag()
    
    init() {
        getNews()
    }
    
    var updatedContent: Observable<Void> {
        return newsList
            .asObservable()
            .distinctUntilChanged({ $0 == $1 })
            .map{ $0.count > 0 }
    }
    
    func getNews() {
        let manager = NewsManager()
        manager
            .getNews()
            .bind(to: newsList)
            .disposed(by: disposeBag)
    }
}
