//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var rpositryImage: UIImageView!
    
    @IBOutlet weak var repositryTitle: UILabel!
    
    @IBOutlet weak var inLanguage: UILabel!
    
    @IBOutlet weak var NumOfStargazzer: UILabel!
    @IBOutlet weak var NumofWatch: UILabel!
    @IBOutlet weak var NumofFork: UILabel!
    @IBOutlet weak var Numofissue: UILabel!
    
    var homeVC: ViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repsitory = homeVC.repositories[homeVC.numberOfCellSelected]
        
        inLanguage.text = "Written in \(repsitory["language"] as? String ?? "")"
        NumOfStargazzer.text = "\(repsitory["stargazers_count"] as? Int ?? 0) stars"
        NumofWatch.text = "\(repsitory["wachers_count"] as? Int ?? 0) watchers"
        NumofFork.text = "\(repsitory["forks_count"] as? Int ?? 0) forks"
        Numofissue.text = "\(repsitory["open_issues_count"] as? Int ?? 0) open issues"
        getImagefromRepository()
    }
    
    func getImagefromRepository(){
        let repositry = homeVC.repositories[homeVC.numberOfCellSelected]
        
        repositryTitle.text = repositry["full_name"] as? String
        
        if let owner = repositry["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    guard let img = UIImage(data: data!) else{
                        return 
                    }
                    
                    DispatchQueue.main.async {
                        self.rpositryImage.image = img
                    }
                }.resume()
            }
        }
    }
}
