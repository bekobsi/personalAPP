//
//  FirstViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//

import UIKit



extension Date {
    var weekday: String {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.component(.weekday, from: self)
        let weekday = component - 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        return formatter.weekdaySymbols[weekday]
    }
}


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

            names = name as! Array
            huriganas = hurigana as! Array<String>
            for count in 0 ..< names.count {

            let search = member.contains(where: {$0.name == names[count] })
            if search == false{
                
                member.append((name:names[count],hurigana:huriganas[count]))
                print(member)
            }
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
        return member.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menberCell = tableView.dequeueReusableCell(withIdentifier: "menberCell", for: indexPath)
        //-----------------------並び替えるもメソッド。----------------
                menberCell.textLabel?.text = member.sorted(by: { ($0.hurigana as String)   < ($1.hurigana as String)})[indexPath.row].name
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
