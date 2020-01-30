//
//  SecondViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//
import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
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
    
//-----------セル個数を指定するデリゲートメソッド------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    //----------セルに値を設定するデータソースメソッド-------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bathMember = tableView.dequeueReusableCell(withIdentifier: "bathMember", for: indexPath)
        bathMember.textLabel?.text = names[indexPath.row]
        
        return bathMember
        }
    
    

    }
