//
//  GithubRepoViewModel.swift
//  Jan2017GithubViewer
//
//  Created by Brendan Seabrook on 2018-01-15.
//  Copyright © 2018 Brendan Seabrook. All rights reserved.
//

import UIKit

@objcMembers class GithubRepoViewModel : NSObject {
    
    let forModelObject:GithubRepo
    
    init(forModelObject modelObject:GithubRepo) {
        self.forModelObject = modelObject
        super.init()
    }
    
    public var name:String? {
        return forModelObject.record["name"] as? String
    }
    
    public var stars:String {
        return String(describing: forModelObject.record["stargazers_count"] as? Int ?? 0)
    }
    
    public var starsLabel:String {
        return NSLocalizedString("★ \(stars) Stars", comment: "Label displaying a black star, the number of stars the repo has")
    }
    
    public var forks:String {
        return String(describing: forModelObject.record["forks_count"] as? Int ?? 0)
    }
    
    public var forksLabel:String {
        return NSLocalizedString("⇆ \(forks) Forks", comment: "Label displaying a symbol for forking a repo, the number of forks on this repo")
    }
    
    public var repoDescription:String? {
        return forModelObject.record["description"] as? String
    }
    
    private var owner:[String:Any]? {
        return forModelObject.record["owner"] as? [String:Any]
    }
    
    public var ownersName:String? {
        return owner?["login"] as? String
    }
    
    public var portraitURL:String? {
        return owner?["avatar_url"] as? String
    }
    
    public var portrait:UIImage? {
        guard forModelObject.portrait != nil else {
            return nil
        }
        return UIImage(data: forModelObject.portrait! as Data)
    }
    
    public var portraitInCircle:UIImage? {
        guard let portrait = self.portrait else {
            return nil
        }
        
        guard let masked = portrait.cgImage?.masking(UIImage(named: "mask")!.cgImage!) else {
            return nil
        }
        
        return UIImage(cgImage: masked)
    }
    
    private var portraitObserver:NSKeyValueObservation?
    func bindToImage(onChange:@escaping ()->Void) {
        portraitObserver = forModelObject.observe(\.portrait, changeHandler: { (model, change) in
            onChange()
        })
    }
    
    var fullName:String? {
        return forModelObject.record["full_name"] as? String
    }
    
    var readmeURL:String? {
        guard let fullName = self.fullName else {
            return nil
        }

        return "https://raw.githubusercontent.com/\(fullName)/master/README.md"
    }
    
    var readme:String? {
        if forModelObject.readme == nil {
            return nil
        }
        return String(data: forModelObject.readme! as Data, encoding: .utf8)
    }
    
    private var readmeObserver:NSKeyValueObservation?
    func bindToReadme(onChange:@escaping ()->Void) {
        readmeObserver = forModelObject.observe(\.readme, changeHandler: { (model, change) in
            onChange()
        })
    }
}
