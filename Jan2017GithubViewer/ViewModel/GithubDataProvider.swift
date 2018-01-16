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
        config.httpAdditionalHeaders = [:
//            "Authorization": "Bearer " + "qY92NeZMw__mYbfUN4gx_Naul1EZhy-Is3HHwL1-f9XB2VL_rb0ryDrd8iGDFslU4LAiKKwChj_tOahwW_aka1kDIQlW-InHxEZG9J3rL69I85rqrHW52KTjB3VYWnYx"
        ]
    }
    
    @objc dynamic var trending:[GithubRepoViewModel] = []
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
}
