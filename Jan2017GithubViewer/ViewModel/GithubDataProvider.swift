//
//  GithubDataProvider.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import Foundation

class GithubDataProvider : NSObject {
    public static let shared = GithubDataProvider()
    
    private var config: URLSessionConfiguration!
    
    override init() {
        config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [:]
    }
    
    @objc dynamic var trending:[GithubRepoViewModel] = []
    private var trendingObserver:NSKeyValueObservation?
    func bindToTrending(onChange:@escaping ()->Void) {
        trendingObserver = self.observe(\.trending, changeHandler: { (model, change) in
            onChange()
        })
    }
    
    
    @objc dynamic var error:String = "" //Not ideal but Error enum not workable with @objc
    
    public func updateTrending() {
        guard let url = URL(string: "https://api.github.com/search/repositories", queryComponents:
        [
            "sort":"stars",
            "order":"desc",
            "q":"swift"
            //TODO add date range
        ]) else {
            //TODO Log and return
            return
        }
        
        let session = URLSession(configuration: self.config)
        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if data == nil || error != nil || (response as? HTTPURLResponse)?.statusCode != 200 {
                //TODO Log and return
                return
            }

            guard let results = (try? JSONSerialization.jsonObject(with: data!, options: .init(rawValue: 0))) as? Dictionary<String,Any> else {
                //TODO Log and return
                return
            }
            
            guard let records = results["items"] as? Array<Dictionary<String, Any>> else {
                //TODO log and return
                return
            }
            
            self.trending = records.map({ (record) -> GithubRepoViewModel in
                return GithubRepoViewModel(forModelObject: GithubRepo(forRecord: record))
            })
        })
        dataTask.resume()
    }
    
    private func updatePortrait(repo:GithubRepoViewModel) {
        guard let portraitURLString = repo.portraitURL else {
            return
        }
        
        guard let portraitURL = URL(string: portraitURLString) else {
            return
        }
        
        let session = URLSession(configuration: self.config)
        let portraitTask = session.dataTask(with: portraitURL, completionHandler: { (data, response, error) in
            if data == nil || error != nil || (response as? HTTPURLResponse)?.statusCode != 200 {
                //TODO Log and return
                return
            }
            
            repo.forModelObject.portrait = NSData(data: data!)
        })
        portraitTask.resume()
    }
    
    private func updateReadme(repo:GithubRepoViewModel) {
        guard let readmeURLString = repo.readmeURL else {
            return
        }
        
        guard let readmeURL = URL(string: readmeURLString) else {
            return
        }
        
        let session = URLSession(configuration: self.config)
        let readmeTask = session.dataTask(with: readmeURL, completionHandler: { (data, response, error) in
            if data == nil || error != nil || (response as? HTTPURLResponse)?.statusCode != 200 {
                //TODO Log and return
                return
            }
            
            repo.forModelObject.readme = NSData.init(data: data!)
        })
        readmeTask.resume()
    }
    
    public func updateRepo(repo:GithubRepoViewModel) {
        updatePortrait(repo: repo)
        updateReadme(repo: repo)
    }
}
