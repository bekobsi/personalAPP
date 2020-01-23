//
//  MemberAdditionViewController.swift
//  personal APP
//
//  Created by 原直也 on 2020/01/19.
//  Copyright © 2020 原直也. All rights reserved.
//

import UIKit
//---------変数の定義-------------


var fullName:[String] = []
var gender = "男性"


class MemberAdditionViewController: UIViewController ,UITextFieldDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameAdd.keyboardType = .namePhonePad
        fullNameAdd.delegate = self
        fullNameAdd.placeholder = "スペースを入れずに入力"
        fullNameAdd.returnKeyType = .done
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //  名前のtextField
    @IBOutlet weak var fullNameAdd: UITextField!
    //    性別選択のボタン
    
    
    @IBAction func genderButton(_ sender: UISegmentedControl) {
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
        
        
        let alertController = UIAlertController(
            
            title: "以下の内容でよろしいですか？",
            message: "登録する方の氏名：\(fullNameAdd.text!)\n\(gender)",
            preferredStyle:  UIAlertController.Style.alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: nil
            )
        )
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler:{action in
                    UserDefaults.standard.set(fullName, forKey:"fullName" )
            }
            )
        )
        
        present(alertController,animated: true,completion: nil)
    }
    
    //-------------ここまでアラート表示メソッド------------------------
    
    
    
    
    
    //------------キーボード以外を押すとキーボードが下がる機能-----------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //------------キーボードの改行を押すと、キーボードが下がる機能-----------
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
