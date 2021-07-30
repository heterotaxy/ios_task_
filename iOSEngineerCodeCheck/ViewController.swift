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
    
    var gitHubUrlsessiontask =  GitHubSessionTask()
    var searchword: String!
    var repositoryUrl: String!
    var numberOfCellSelected: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        
        
    }
    //MARK: - 検索バーの表示
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        gitHubUrlsessiontask.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchword = searchBar.text!
        
        if searchword.count != 0 {
            gitHubUrlsessiontask.updateSearchWord(searchword: searchword)
            gitHubUrlsessiontask.loadRepositories()
            repositories = gitHubUrlsessiontask.getRepositoriesData()
                
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            // これ呼ばなきゃリストが更新されません
            gitHubUrlsessiontask.updateRepositories()
        }
    }
    //MARK: - 別のview contorollerに遷移するときに呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.identifier == "Detail"の時に情報を送る。
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! ViewController2
            dtl.homeVC = self
        }
    }
    //MARK: - ui table view の設定（表示）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
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
