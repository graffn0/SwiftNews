//
//  ViewController.swift
//  SwiftNews
//
//  Created by Nicholas Graff on 11/28/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    var selectedNews: News?
    
    enum segueError: Error {
        case error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel
            .updatedContent
            .do(onNext: { [weak self] _ in
                guard let me = self else { return }
                me.tableView.reloadData()
            })
            .observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let detailVC = segue.destination as? DetailViewController, let news = selectedNews else { return }
        detailVC.selectedNews = news
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "newsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        cell.setViewModel(news: viewModel.newsList.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNews = viewModel.newsList.value[indexPath.row]
        performSegue(withIdentifier: "mainToDetail", sender: self)
    }
}

