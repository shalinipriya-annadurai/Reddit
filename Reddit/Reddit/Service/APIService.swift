//
//  APIService.swift
//  Reddit
//
//  Created by Shalinipriya Annadurai on 10/2/21.
//

import Foundation

class APIService :  NSObject {
    
    //private let sourcesURL = URL(string: "https://www.reddit.com/.json")!
    
    func apiToGetFeeds(completion : @escaping ([Feed]) -> ()){
        
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string:"http://www.reddit.com/.json") else {
            print("Invalid URL")
            return
        }
        let task = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("BAD Server Response")
                return
            }
            
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let jsonDict = json as? [AnyHashable : Any]
                    let data = jsonDict?["data"] as? [AnyHashable : Any]
                    let children = data?["children"] as? [Any]
                    var feeds: [Feed] = []
                    children?.forEach({dataDict in
                        let data = dataDict as? [AnyHashable: Any]
                        let award = data?["data"] as? [AnyHashable: Any]
                        
                        feeds.append(Feed(title: award?["title"] as? String, comments: award?["num_comments"] as? Int, thumbnail: award?["thumbnail"] as? String, score: award?["score"] as? Int))
                    })
                    completion(feeds)
                } catch {
                    print("Invalid JSON")
                }
            }
        }
        task.resume()
    }
}
