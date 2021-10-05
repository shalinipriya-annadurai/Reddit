//
//  FeedsViewModel.swift
//  Reddit
//
//  Created by Shalinipriya Annadurai on 10/2/21.
//

import Foundation

class FeedsViewModel: NSCoder {
    
    private var apiService: APIService!
    
    private(set) var feeds = [Feed](){
        didSet{
            bindingFeedstoController()
        }
    }
    var bindingFeedstoController: (()->()) = {}
    override init() {
        super.init()
        self.apiService = APIService()
        getFeeds()
    }
     
    func getFeeds() {
        self.apiService.apiToGetFeeds(endPoint: .fetchData) {[weak self] (feeds) in
            self?.feeds.append(contentsOf: feeds)
        }
    }
    
    func getMoreFeeds() {
        self.apiService.apiToGetFeeds(endPoint: .fetchMore){[weak self] (feeds) in
            self?.feeds.append(contentsOf: feeds)
        }
    }
}
