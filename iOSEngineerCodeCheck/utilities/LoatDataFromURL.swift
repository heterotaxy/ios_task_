//
//  LoatDataFromURL.swift
//  iOSEngineerCodeCheck
//
//  Created by 高橋晴矢 on 2021/07/30.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

class GitHubSessionTask{
    var repositoryUrl: String?
    var gitHubUrlsessiontask: URLSessionTask?
    var repositories: [[String: Any]]=[]
    
    func GitHubSessionTask(){}
    
    func loadRepositories(){
        gitHubUrlsessiontask = URLSession.shared.dataTask(with: URL(string: self.repositoryUrl!)!) { (data, res, err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                if let items = obj["items"] as? [[String: Any]] {
                    self.repositories = items
                }
            }
        }
    }
    
    func updateSearchWord(searchword :String){
        self.repositoryUrl = "https://api.github.com/search/repositories?q=\(searchword)"
    }
    
    func getRepositoriesData()->[[String: Any]]{
        return repositories
    }
    
    func updateRepositories(){
        gitHubUrlsessiontask?.resume();
    }
    
    func cancel(){
        gitHubUrlsessiontask?.cancel()
    }
}
