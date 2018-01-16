//
//  GithubRepoViewModel.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import Foundation
@objcMembers class GithubRepoViewModel : NSObject {
    
    let forModelObject:GithubRepo
    
    init(forModelObject modelObject:GithubRepo) {
        self.forModelObject = modelObject
        super.init()
    }
    
    public var name:String? {
        return forModelObject.record["name"] as? String
    }
    
    public var stars:String? {
        return forModelObject.record["stars"] as? String
    }
    
    public var repoDescription:String? {
        return forModelObject.record["description"] as? String
    }
}
