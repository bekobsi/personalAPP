//
//  MemberAdditionViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//

import UIKit
//---------変数の定義-------------

var mamber:[(name:String,hurigana:String,Gender:Bool)] = []
var fullName:[String] = []
var gender = "男性"


class MemberAdditionViewController: UIViewController ,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         print("リターン入力時")
         // キーボードを閉じる
         textField.resignFirstResponder()
         // これでも閉じる
         // textField.endEditing(true)
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
        
        
        
        


        
        // Do any additional setup after loading the view.
    }
//-----------ふりがなを入力するtextField
    @IBOutlet weak var huriganaAdd: UITextField!
    //  名前のtextField
    @IBOutlet weak var fullNameAdd: UITextField!
    
    
//-----------性別を設定するSegmentControlボタン
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
        print(gender)
    }
    
    
    @IBAction func userSignUp(_ sender: Any) {
        
//        fullName内に入力した名前を保存
        UserDefaults.standard.set(fullName, forKey:"fullName" )
        
        //--------------アラート表示のメソッド--------------------------
        
        if let text = fullNameAdd.text, text.isEmpty{
            let alertController = UIAlertController(
                
                
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
            
        
                
                
        }else{
         let alertController = UIAlertController(


             title: "以下の内容でよろしいですか？",
             message: "登録する方の氏名：\(fullNameAdd.text!)\n\(huriganaAdd.text!)\n\(gender)",
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
                     UserDefaults.standard.set(fullName, forKey:"fullName" )
//                     let MemberController = MemberAdditionViewController()
                     self.performSegue(withIdentifier: "MemberController", sender: nil)

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
    
    //------------キーボードの改行を押すと、キーボードが下がる機能-----------

}

