//
//  ViewController.swift
//  Reddit
//
//  Created by Shalinipriya Annadurai on 10/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    private var viewModel : FeedsViewModel!
    
    private var dataSource : HomePageTableViewDataSource<FeedViewCell, Feed>!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.setUpList()
    }
    
    func setUpList(){
        self.tableView.frame = self.view.frame
        self.tableView.register(FeedViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "loadingcell")
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.viewModel =  FeedsViewModel()
        self.viewModel.bindingFeedstoController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        guard let feeds = self.viewModel?.feeds else {
            return
        }
        self.dataSource = HomePageTableViewDataSource(cellIdentifier: "cell", items: feeds, configureCell: { (cell, feed) in
            cell.tileLabel.text = feed.title
            if let imageURL = feed.imageURL, let data = try? Data(contentsOf: imageURL){
                cell.thumbnail.image = UIImage(data: data)
            }
            cell.commentsLabel.text = "Comments: \(feed.comments ?? 0)"
            cell.scoreLabel.text = "Score: \(feed.score ?? 0)"
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.feeds.count - 1 {
            self.viewModel.getFeeds()
        }
    }
}
