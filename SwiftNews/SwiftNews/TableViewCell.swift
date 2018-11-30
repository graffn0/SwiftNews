//
//  TableViewCell.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit
import RxSwift

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var newsImg: UIImageView!
    
    var newsViewModel = PublishSubject<News>()
    let disposeBag = DisposeBag()
    
    func setViewModel(news: News) {
        self.newsViewModel.onNext(news)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        newsViewModel
            .subscribe(onNext: { [weak self] news in
                if let title = news.title {
                    self?.titleLbl.text = title
                } else { self?.titleLbl.text = "" }
                
                if let source = news.source?.name {
                    self?.sourceLbl.text = source
                } else { self?.sourceLbl.text = "" }
                
                if let author = news.author {
                    self?.infoLbl.text = "\(author) "
                } else { self?.infoLbl.text = "" }
                
                if let date = news.publishedDate {
                    self?.infoLbl.text?.append(contentsOf: date)
                }
                
                if let description = news.description {
                    self?.descriptionLbl.text = description
                } else { self?.descriptionLbl.text = "" }
                
                if let imageString = news.urlToImage {
                    self?.newsImg.downloaded(from: imageString)
                }
            })
            .disposed(by: disposeBag)
    }
}
