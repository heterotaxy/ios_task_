//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [[String: Any]]=[]
    
    var gitHubUrlsessiontask: LoadRepository?
    //search bar のボタンが押された時絶対に値が入る
    var searchword: String!
    var repositoryUrl: String?
    //nilの状態で利用されることはない
    var numberOfCellSelected: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        
        gitHubUrlsessiontask = LoadRepository(vc: self)
    }
    //MARK: - 検索バーの表示
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        gitHubUrlsessiontask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchword = searchBar.text!
        
        if searchword.count != 0{
            guard let word = searchword else{
                return
            }
            gitHubUrlsessiontask?.settingTask(searchword: word)
            //設定さらたタスクを実行
            gitHubUrlsessiontask?.resume()
        }
    }
    //MARK: - 別のview contorollerに遷移するときに呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.identifier == "Detail"の時に情報を送る。
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! RepositoryView
            dtl.homeVC = self
        }
    }
    //MARK: - ui table view の設定（表示）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "repository")
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        numberOfCellSelected = indexPath.row
        //sequeidentifierがdetailであるVCに遷移する。遷移する際にはprepare() methodが呼ばれる
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
