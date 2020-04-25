//
//  FirstViewController.swift
//  CNPS
//
//  Created by kazuki.abe on 2020/04/19.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var talkTable: UITableView!
    
    @IBOutlet weak var chat_text: UITextField!
    @IBOutlet weak var send_button: UIImageView!
    
    private var chat = "入力してね"
    @IBOutlet weak var tab_first: UITabBarItem!

    // UIButtonのインスタンスを作成する
    let button_yes = UIButton(type: UIButton.ButtonType.system)
    let button_no = UIButton(type: UIButton.ButtonType.system)
    
    var fruits = ["apple", "orange", "melon", "banana", "pineapple"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.chat_text.borderStyle = .roundedRect
        
        let mainScreenHeight = UIScreen.main.bounds.size.height
        
        let mainScreenwidth = UIScreen.main.bounds.size.width
        
        let tabBarController: UITabBarController = UITabBarController()
        let tabBarHieght = tabBarController.tabBar.frame.size.height
        print(mainScreenHeight,tabBarHieght)
        
        let blank_size = mainScreenwidth/12
        
        self.chat_text.borderStyle = UITextField.BorderStyle.roundedRect
        
        self.chat_text.frame = CGRect(x:blank_size,y:mainScreenHeight-tabBarHieght-34,width: mainScreenwidth-2*blank_size-32, height: 34)
       
        self.view.addSubview(self.chat_text)
        
        let right_chat_text = chat_text.frame.origin.x + chat_text.frame.size.width
        
        self.send_button.frame = CGRect(x:right_chat_text,y:mainScreenHeight-tabBarHieght-34,width: 32, height: 34)
        
        send_button.isUserInteractionEnabled = true
        
        send_button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FirstViewController.imageViewTapped(_:))))
        
        button_yes.addTarget(self, action:#selector( pussYesNoButton(_:)), for: UIControl.Event.touchUpInside)
        button_no.addTarget(self, action:#selector( pussYesNoButton(_:)), for: UIControl.Event.touchUpInside)


        // ラベルを設定する
        button_yes.setTitle("はい", for: UIControl.State.normal)
        button_no.setTitle("いいえ", for: UIControl.State.normal)

        button_yes.setTitleColor(UIColor.white, for: .normal)
        button_no.setTitleColor(UIColor.white, for: .normal)
        
        button_yes.layer.borderWidth = 1
        button_no.layer.borderWidth = 1
        
        button_yes.layer.borderColor = UIColor(red:0,green:150/255.0,blue:0,alpha:1.0).cgColor
        button_no.layer.borderColor = UIColor(red:0,green:150/255.0,blue:0,alpha:1.0).cgColor
        

        button_yes.backgroundColor = UIColor(red:0,green:150/255.0,blue:0,alpha:1.0)
        button_no.backgroundColor = UIColor(red:0,green:150/255.0,blue:0,alpha:1.0)
        
        button_yes.layer.cornerRadius = 5
        button_no.layer.cornerRadius = 5
        
        button_yes.frame = CGRect(x: 0, y: 0, width: 75, height: 30)
        button_no.frame = CGRect(x: 0, y: 0, width: 75, height: 30)
        
        
        button_yes.layer.position = CGPoint(x: self.view.frame.width/5, y:self.chat_text.frame.origin.y-button_yes.frame.height/2-4)
        button_no.layer.position = CGPoint(x: 2*self.view.frame.width/5, y:self.chat_text.frame.origin.y-button_yes.frame.height/2-4)

        // viewに追加する
        self.view.addSubview(button_yes)
        self.view.addSubview(button_no)
    }
    
    func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                } else {
                    let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                    self.view.frame.origin.y -= suggestionHeight
                }
            }
    }
                
    func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
                
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 画像がタップされたら呼ばれる
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        //空文字判定は課題
        chat = (chat_text.text) ?? "入力してね"
        chat_text.text = ""
        print(chat)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func pussYesNoButton(_ senfer: UIButton) {
        self.fruits += [senfer.title(for: .normal)!]
        self.talkTable.reloadData()
    }

}
extension FirstViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }



}
