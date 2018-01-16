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
    //Cant use swift native struct here, not KVO
    @objc dynamic var portrait:NSData?
    @objc dynamic var readme:NSData?
    
    init(forRecord:[String:Any]) {
        record = forRecord
    }
}
