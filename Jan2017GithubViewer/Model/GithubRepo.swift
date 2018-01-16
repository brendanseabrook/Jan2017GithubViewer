//
//  GithubRepo.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import Foundation

class GithubRepo : NSObject {
    var record:[String:Any]
    
    init(forRecord:[String:Any]) {
        record = forRecord
    }
}
