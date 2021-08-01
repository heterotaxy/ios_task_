//
//  LoatDataFromURL.swift
//  iOSEngineerCodeCheck
//
//  Created by 高橋晴矢 on 2021/07/30.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

protocol GitHubSessionTask {
    var urlString: String? {get}
    var gitHubUrlsessiontask: URLSessionTask? {get}
    
    func cancel()
    func resume()
}

class LoadRepository: GitHubSessionTask{
    var urlString: String?
    var gitHubUrlsessiontask: URLSessionTask?
    weak var vc: ViewController?
    
    init(vc : ViewController?){
        self.vc = vc
    }
    
    func settingTask(searchword: String){
        urlString = "https://api.github.com/search/repositories?q=\(searchword)"
        guard let url = URL(string: urlString!) else{
            return
        }
        
        gitHubUrlsessiontask = URLSession.shared.dataTask(with: url){[weak self] (data,res,err) in
            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any]{
                if let items = obj["items"] as? [[String: Any]] {
                    self?.vc?.repositories = items
                    
                    DispatchQueue.main.async {
                        self?.vc?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func resume() {
        gitHubUrlsessiontask?.resume()
    }
    
    func cancel() {
        gitHubUrlsessiontask?.cancel()
    }
}

class LoadRepositoryImage: GitHubSessionTask{
    var urlString: String?
    var gitHubUrlsessiontask: URLSessionTask?
    
    weak var vc: RepositoryView?
    
    init(vc: RepositoryView){
        self.vc = vc
    }
    
    func loadRepositoryImage(imageurl: String){
        gitHubUrlsessiontask = URLSession.shared.dataTask(with: URL(string: imageurl)!){
            [weak self] (data, res, err) in
            guard let img = UIImage(data: data!) else{
                return
            }
            
            DispatchQueue.main.async {
                self?.vc?.rpositryImage.image = img
            }
        }
    }
    
    func cancel() {
        gitHubUrlsessiontask?.cancel()
    }
    
    func resume() {
        gitHubUrlsessiontask?.resume()
    }
    
    
}
