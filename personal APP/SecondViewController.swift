//
//  SecondViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//
import UIKit

var trueCount = 0
var manTrueCount = 0
var ladiesTrueCount = 0
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
        if let name = userDefaults.stringArray(forKey: "names"),let hurigana = userDefaults.stringArray(forKey: "huriganas"),let gender = userDefaults.stringArray(forKey: "gender"){
            
            names = name
            huriganas = hurigana
            genders = gender
            bathWeeksAdd = userDefaults.object(forKey: "bathWeeksAdd") as! [[String]]
            
            
            
            self.tableView.reloadData() //データをリロードする
            
            func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                tableView.dataSource = self
                tableView.delegate = self
                tableView.allowsMultipleSelection = true //tableVewを複数選択できる
                
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "rowButtonAction")
                    longPressRecognizer.allowableMovement = 15
                    longPressRecognizer.minimumPressDuration = 0.6
                    self.tableView .addGestureRecognizer(longPressRecognizer)
                

                
                
            }
        }
    }
    
    
    func rowButtonAction(sender : UILongPressGestureRecognizer) {
        
        let point: CGPoint = sender.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if let indexPath = indexPath {
            if sender.state == UIGestureRecognizer.State.began {
                
                // セルが長押しされたときの処理
                print("long pressed \(indexPath.row)")
            }
        }else{
            print("long press on table view")
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
            memberTotalCount.text = "全体の人数:あと\(trueCount - testInt)人です"
            tableView?.reloadData()
            
        case 1:
            bathMember = []
            trueCount = 0
            manTrueCount = 0
            
            for count in 0 ..< member.count{
                
                if member[count].bathWeek.isEmpty == false && member[count].gender == "男性" && member[count].bathWeek.contains(date.weekday) == true
                {
                    bathMember.append(member[count])
                    trueCount += 1
                    manTrueCount += 1
                }
            }
            
            memberTotalCount.text = "男性の人数:あと\(manTrueCount)人です"
            tableView?.reloadData()
            
            
        case 2:
            bathMember = []
            trueCount = 0
            ladiesTrueCount = 0
            
            for count in 0 ..< member.count{
                if member[count].bathWeek.isEmpty == false && member[count].gender == "女性" && member[count].bathWeek.contains(date.weekday) == true{
                    bathMember.append(member[count])
                    trueCount += 1
                    ladiesTrueCount += 1
                }
            }
            
            
            memberTotalCount.text = "女性の人数:あと\(ladiesTrueCount)人です"
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
//                return 0
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
        }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

        }
    }
    


}
