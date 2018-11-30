//
//  DetailViewController.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var newsImg: UIImageView!
    
    var selectedNews: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let news = selectedNews else {
            return
        }
        setup(news: news)
        // Do any additional setup after loading the view.
    }
    
    func setup(news: News) {
        if let title = news.title {
            titleLbl.text = title
        } else { titleLbl.text = "" }
        
        if let source = news.source?.name {
            sourceLbl.text = source
        } else { sourceLbl.text = "" }
        
        if let author = news.author {
            infoLbl.text = "\(author) "
        } else { infoLbl.text = "" }
        
        if let date = news.publishedDate {
            infoLbl.text?.append(contentsOf: date)
        }
        
        if let content = news.content {
            contentLbl.text = content
        } else { contentLbl.text = "" }
        
        if let imageString = news.urlToImage {
            newsImg.downloaded(from: imageString)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
