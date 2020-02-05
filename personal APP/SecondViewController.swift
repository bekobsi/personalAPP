//
//  SecondViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//
import UIKit

var trueCount = 0
var trueCountArray = [Int]()
var bathMember = [(name:String,hurigana:String,gender:String,bathWeek:[String])]()

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var didBack: (() -> Void)?
    override func didMove(toParent parent: UIViewController?) {
        // -------------userDefaults内のデータをアンラップ
        if let name = userDefaults.object(forKey: "names"),let hurigana = userDefaults.object(forKey: "huriganas"),let gender = userDefaults.object(forKey: "gender"){

             names = name as! Array
             huriganas = hurigana as! Array<String>
             genders = gender as! Array<String>
             bathWeeksAdd = userDefaults.object(forKey: "bathWeeksAdd") as! [[String]]


            
            self.tableView.reloadData() //データをリロードする
            
            func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                tableView.dataSource = self
                tableView.delegate = self
  
                
            }
        }
    }

    @IBAction func bathGender(_ sender: Any) {
    }
    @IBOutlet weak var memberTotalCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//-----------セル個数を指定するデリゲートメソッド------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trueCount = 0
        for count in 0 ..< member.count{
            if member[count].bathWeek.isEmpty == false{
                trueCount += 1
            }
        }
        memberTotalCount.text = "全体の人数は\(trueCount)人です"
        
        return trueCount
    }
    //----------セルに値を設定するデータソースメソッド-------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bathMemberCell = tableView.dequeueReusableCell(withIdentifier: "bathMemberCell", for: indexPath)



        
        bathMemberCell.textLabel?.text = bathMember.sorted(by: { ($0.hurigana as String)   < ($1.hurigana as String)})[indexPath.row].name
 return bathMemberCell
    
    }
    }





