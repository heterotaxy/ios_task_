//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryView: UIViewController {
    
    @IBOutlet weak var rpositryImage: UIImageView!
    
    @IBOutlet weak var repositryTitle: UILabel!
    
    @IBOutlet weak var inLanguage: UILabel!
    
    @IBOutlet weak var NumOfStargazzer: UILabel!
    @IBOutlet weak var NumofWatch: UILabel!
    @IBOutlet weak var NumofFork: UILabel!
    @IBOutlet weak var Numofissue: UILabel!
    
    weak var homeVC: ViewController!
    var gitHubUrlSessionTask: LoadRepositoryImage?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        gitHubUrlSessionTask = LoadRepositoryImage(vc: self)
        getImagefromRepository()
        
        updateUILabel()
    }
    
    func getImagefromRepository(){
        let repositry = homeVC.repositories[homeVC.numberOfCellSelected]
        
        repositryTitle.text = repositry["full_name"] as? String
        
        if let owner = repositry["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                gitHubUrlSessionTask?.loadRepositoryImage(imageurl: imgURL)
                gitHubUrlSessionTask?.resume()
            }
        }
    }
    
    func updateUILabel(){
        let repsitory = homeVC.repositories[homeVC.numberOfCellSelected]
        
        inLanguage.text = "Written in \(repsitory["language"] as? String ?? "")"
        NumOfStargazzer.text = "\(repsitory["stargazers_count"] as? Int ?? 0) stars"
        NumofWatch.text = "\(repsitory["watchers"] as? Int ?? 0) watchers"
        NumofFork.text = "\(repsitory["forks_count"] as? Int ?? 0) forks"
        Numofissue.text = "\(repsitory["open_issues_count"] as? Int ?? 0) open issues"
    }
}
