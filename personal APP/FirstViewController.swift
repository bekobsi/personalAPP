//
//  FirstViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//

import UIKit
var member:[(name:String,hurigana:String)] = []


class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var didBack: (() -> Void)?
    override func didMove(toParent parent: UIViewController?) {
        //                  if let name = UserDefaults.standard.string(forKey: "name"),let hurigana = UserDefaults.standard.string(forKey: "hurigana"){
        //                    let search = member.first{$0.name == name}
        //                       if search == nil{
        //                      let memberAdd = (name,hurigana,gender)
        //                      member.append(memberAdd)
        //                      self.tableView.reloadData()
        //                    print("成功です")
        //                    }
        //    }
        // -------------userDefaults内のデータをアンラップして
        if let name = userDefaults.object(forKey: "names"),let hurigana = userDefaults.object(forKey: "huriganas"){
            names = name as! Array<String>
            huriganas = hurigana as! Array<String>
            for count in 0 ..< names.count {
                member.append((name:names[count],hurigana:huriganas[count]))
                print(member)
            }
            self.tableView.reloadData() //データをリロードする
            
            func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                tableView.dataSource = self
                tableView.delegate = self
                
            }
        }
    }
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //--------------------セルを管理するメソッド-----------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menberCell = tableView.dequeueReusableCell(withIdentifier: "menberCell", for: indexPath)
        //-----------------------並び替えるもメソッド。しかしバグがあるため一旦コメントアウト
        //        menberCell.textLabel?.text = member.sorted(by: { ($0.hurigana as String)   < ($1.hurigana as String)})[indexPath.row].name
        menberCell.textLabel?.text = names[indexPath.row]
        return menberCell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            member.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //--------------------ここまでセルを管理するメソッド---------------------
    
    
    
    
    
    
    
    
    
    
}
