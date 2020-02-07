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
var MamBathMember = [(name:String,hurigana:String,gender:String,bathWeek:[String])]()

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var rowListArray = [Int]()
    var itemListArray = [Int]()
    var sortArray = [Int]()
    var testInt = 0
    
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
                tableView.allowsMultipleSelection = true //tableVewを複数選択できる
                
                
            }
        }
    }
    
    @IBAction func bathGender(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bathMember = []
            trueCount = 0
            
            for count in 0 ..< member.count{
                
                if member[count].bathWeek.isEmpty == false && member[count].bathWeek.contains(date.weekday) == true{
                    bathMember.append(member[count])
                    trueCount += 1
                    
                }
            }
            memberTotalCount.text = "全体の人数:あと\(trueCount)人です"
            tableView?.reloadData()
            
        case 1:
            bathMember = []
            trueCount = 0
            
            for count in 0 ..< member.count{
                
                if member[count].bathWeek.isEmpty == false && member[count].gender == "男性" && member[count].bathWeek.contains(date.weekday) == true
                {
                    bathMember.append(member[count])
                    trueCount += 1
                }
            }
            
            memberTotalCount.text = "男性の人数:あと\(trueCount)人です"
            tableView?.reloadData()
            
            
        case 2:
            bathMember = []
            trueCount = 0
            
            for count in 0 ..< member.count{
                if member[count].bathWeek.isEmpty == false && member[count].gender == "女性" && member[count].bathWeek.contains(date.weekday) == true{
                    bathMember.append(member[count])
                    trueCount += 1
                }
            }
            
            
            memberTotalCount.text = "女性の人数:あと\(trueCount)人です"
            tableView?.reloadData()
            
            
        default:
            memberTotalCount.text = "これはデフォルトです"
        }
    }
    
    @IBOutlet weak var memberTotalCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //-----------セル個数を指定するデリゲートメソッド------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trueCount == 0{
            
            for count in 0 ..< member.count{
                if member[count].bathWeek.isEmpty == false{
                    trueCount += 1
                }
            }
        }
        memberTotalCount.text = "全体の人数:あと\(trueCount - testInt)人です"
        // 使い方
        
        
        return trueCount
        //        return 0
    }
    //----------セルに値を設定するデータソースメソッド-------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bathMemberCell = tableView.dequeueReusableCell(withIdentifier: "bathMemberCell", for: indexPath)
        
        bathMemberCell.textLabel?.text = bathMember.sorted(by: { ($0.hurigana as String)   < ($1.hurigana as String)})[indexPath.row].name
        

        if (rowListArray.contains(indexPath.row)){
             bathMemberCell.accessoryType = .checkmark
         }else{
             bathMemberCell.accessoryType = .none
         }
        
        return bathMemberCell
        
    }
    
    //    選択時のの動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        //  選択したセルにチェックマークが無い場合
        if(cell?.accessoryType == UITableViewCell.AccessoryType.none){
            cell?.accessoryType = .checkmark
            testInt += 1            
        }else{
            //  選択したセルにチェックマークがある場合
            cell?.accessoryType = .none

            testInt -= 1

                }
            print(testInt)
        }
    
}
