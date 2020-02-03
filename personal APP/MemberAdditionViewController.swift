//
//  MemberAdditionViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//
import UIKit

//---------変数の定義-------------

var gender = "男性"
var names:Array<String> = []
var huriganas:Array<String> = []
var bathWeeksAdd = [[String?]]()
var bathWeeks = [[String?]]()
let userDefaults = UserDefaults.standard
var weekDay:[String] = []
func test(bathChecker:[Int]){

    if bathChecker.contains(1) == true && weekDay.contains("月曜日") == false{
        weekDay.append("月曜日")
    }
    if bathChecker.contains(2) == true && weekDay.contains("火曜日") == false{
        weekDay.append("火曜日")
    }
    if bathChecker.contains(3) == true && weekDay.contains("水曜日") == false{
        weekDay.append("水曜日")
    }
    if bathChecker.contains(4) == true && weekDay.contains("木曜日") == false{
        weekDay.append("木曜日")
    }
    if bathChecker.contains(5) == true && weekDay.contains("金曜日") == false{
        weekDay.append("金曜日")
    }
    if bathChecker.contains(6) == true && weekDay.contains("土曜日") == false{
        weekDay.append("土曜日")
        
    }
}


class MemberAdditionViewController: UIViewController ,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    //    曜日取得関連の定義
    var weekDayTemplate:[String] = ["月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"]
    var rowListArray = [Int]()
    var itemListArray = [Int]()
    var sortArray = [Int]()
    
    // キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameAdd.delegate = self
        fullNameAdd.keyboardType = .namePhonePad
        fullNameAdd.placeholder = "スペースを入れずに入力"
        fullNameAdd.returnKeyType = .done
        huriganaAdd.keyboardType = .namePhonePad
        huriganaAdd.placeholder = "スペースを入れずに入力"
        huriganaAdd.returnKeyType = .done
        huriganaAdd.delegate = self
        //-------------tableView関連の設定--------
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true //tableVewを複数選択できる
        tableView.isScrollEnabled = false //tableViewをスクロールさせない
        
        
        if weekDay.isEmpty == false{
        weekDay.removeAll()
        }
        
        // 使い方
          let date = Date()
          print(date) // 2018-06-29 10:35:57 +0000
          print(date.weekday) // 金曜日


        
        // Do any additional setup after loading the view.
    }
    //-----------ふりがなを入力するtextField--------
    @IBOutlet weak var huriganaAdd: UITextField!
    //-----------名前のtextField-----------------
    @IBOutlet weak var fullNameAdd: UITextField!
    //-----------tableView-----------------
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
//--------------tableViewSwith------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDayTemplate.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        Cell.textLabel?.text = weekDayTemplate[indexPath.row]
        
        Cell.backgroundColor = UIColor.clear
        Cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 1.0).cgColor
        Cell.layer.borderWidth = 10
       Cell.layer.borderWidth = 0.4


        //  セルの選択時の背景色を消す
        Cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //  セルの選択状況の判定
        if (rowListArray.contains(indexPath.row)){
            Cell.accessoryType = .checkmark
        }else{
            Cell.accessoryType = .none
        }
        return Cell
    }
    
    //    選択時のの動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        //  選択したセルにチェックマークが無い場合
        if(cell?.accessoryType == UITableViewCell.AccessoryType.none){
            cell?.accessoryType = .checkmark
            self.rowListArray.append(indexPath.row)
        }else{
            //  選択したセルにチェックマークがある場合
            cell?.accessoryType = .none
            let  listNumber = rowListArray.filter ({ (n:Int) -> Bool in
                if n != indexPath.row{
                    return true
                }else{
                    return false
                }})
            rowListArray = listNumber
        }
        
        //  配列を昇順で並び替え、
        //  都道府県コードに変換する。
        sortArray = rowListArray.sorted{$0 < $1}
        itemListArray = sortArray.map{$0 + 1}
//        print(itemListArray)
        test(bathChecker: itemListArray)
    }
    
    
    
    
    
    //-----------性別を設定するSegmentControlボタン------------
    @IBAction func genderButton(_ sender: UISegmentedControl) {
        //        押されているボタンを判断しgenderに代入する文
        switch sender.selectedSegmentIndex {
        case 0:
            gender = "男性"
        case 1:
            gender = "女性"
        default:
            gender = "男性"
        }
    }
    
    
    @IBAction func userSignUp(_ sender: Any) {
                
        //--------------------アラート表示のメソッド--------------------------
        
        if let text1 = fullNameAdd.text,let text2 = huriganaAdd.text , text1.isEmpty || text2.isEmpty{
            let alertController = UIAlertController(
//---------------------------名前が入力されていない時の処理------------------------
                title: "名前を入力してください",
                message: "",
                preferredStyle:  UIAlertController.Style.alert)
            //        決定ボタン
            alertController.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                )
            )
            present(alertController,animated: true,completion: nil)
            
        }else if weekDay.isEmpty == true{ //名前とふりがな両方入力されている時の処理
            let alertController = UIAlertController(
                
                
                title: "以下の内容でよろしいですか？",
                message: "登録する方の氏名：\(fullNameAdd.text!)\n\(huriganaAdd.text!)\n\(gender)\n入浴はなし",
                preferredStyle:  UIAlertController.Style.alert)
            
            //        キャンセルボタン
            alertController.addAction(
                UIAlertAction(
                    title: "キャンセル",
                    style: .cancel,
                    handler: nil
                )
            )
            //        決定ボタン
            alertController.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler:{action in
                        if let name = self.fullNameAdd.text, let hurigana = self.huriganaAdd.text {
                            
                            bathWeeksAdd.append(weekDay)

                            names.append(name)
                            huriganas.append(hurigana)
                            userDefaults.set(names, forKey:"names" )
                            userDefaults.set(huriganas, forKey: "huriganas")
                            userDefaults.set(gender, forKey: "gender")
                            userDefaults.set(bathWeeksAdd, forKey: "bathWeeksAdd")
                            names = userDefaults.object(forKey: "names")as! Array<String>
                            huriganas = userDefaults.object(forKey: "huriganas")as! Array<String>
                            bathWeeks = userDefaults.object(forKey: "bathWeeksAdd") as! [[String?]]
                            for count in 0 ..< names.count {
                                
                                if member.contains(where: {$0.name == names[count] }) == false{
                                    member.append((name:names[count],hurigana:huriganas[count],bathWeeks[count]))
                                }
                            }
                        }
                        self.navigationController?.popViewController(animated: true)
                }
                )
            )
            present(alertController,animated: true,completion: nil)
        }else{
            let alertController = UIAlertController(
                
                
                title: "以下の内容でよろしいですか？",
                message: "登録する方の氏名：\(fullNameAdd.text!)\n\(huriganaAdd.text!)\n\(gender)\n入浴する曜日は:\(weekDay.joined(separator: ","))",
                preferredStyle:  UIAlertController.Style.alert)
            
            //        キャンセルボタン
            alertController.addAction(
                UIAlertAction(
                    title: "キャンセル",
                    style: .cancel,
                    handler: nil
                )
            )
            //        決定ボタン
            alertController.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler:{action in
                        if let name = self.fullNameAdd.text, let hurigana = self.huriganaAdd.text {
                            
                            bathWeeksAdd.append(weekDay)

                            names.append(name)
                            huriganas.append(hurigana)
                            userDefaults.set(names, forKey:"names" )
                            userDefaults.set(huriganas, forKey: "huriganas")
                            userDefaults.set(gender, forKey: "gender")
                            userDefaults.set(bathWeeksAdd, forKey: "bathWeeksAdd")
                            names = userDefaults.object(forKey: "names")as! Array<String>
                            huriganas = userDefaults.object(forKey: "huriganas")as! Array<String>
                            bathWeeks = userDefaults.object(forKey: "bathWeeksAdd") as! [[String]]
                            for count in 0 ..< names.count {
                                if member.contains(where: {$0.name == names[count] }) == false{
                                    member.append((name:names[count],hurigana:huriganas[count],bathWeek:bathWeeks[count]))
                                    
                                    print("曜日\(bathWeeksAdd)")
                                    print("\nメンバー\(member)")
                                    }
                            }
                        }
                        self.navigationController?.popViewController(animated: true)
                }
                )
            )
            present(alertController,animated: true,completion: nil)
            
        }
    }
    //-------------ここまでアラート表示メソッド------------------------
    
    //------------キーボード以外を押すとキーボードが下がる機能-----------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
