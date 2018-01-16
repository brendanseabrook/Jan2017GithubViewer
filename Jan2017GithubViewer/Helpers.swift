//
//  Helpers.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import Foundation

extension URL {
    public init?(string:String, queryComponents:[String:String]) {
        let parsedComponents = queryComponents.map { (key, value) -> String? in
            guard let encoded = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return nil
            }
            return key + "=" + encoded
        }
        
        guard parsedComponents.count == queryComponents.count else {
            return nil
        }
        
        self.init(string: string + (parsedComponents.count > 0 ? "?" : "") + (parsedComponents as! [String]).joined(separator: "&"))
    }
}
