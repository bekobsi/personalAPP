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
        // -------------userDefaults内のデータをアンラップ
        if let name = userDefaults.object(forKey: "names"),let hurigana = userDefaults.object(forKey: "huriganas"),let bathWeek = userDefaults.object(forKey: "bathWeek"){
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
        return member.count
    }
    //----------セルに値を設定するデータソースメソッド-------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bathMemberCell = tableView.dequeueReusableCell(withIdentifier: "bathMemberCell", for: indexPath)
        //-----------------------並び替えるもメソッド。
        if bathWeeks.isEmpty == false{
                bathMemberCell.textLabel?.text = member.sorted(by: { ($0.hurigana as String)   < ($1.hurigana as String)})[indexPath.row].name
        }
        return bathMemberCell

        }
    
    

    }
