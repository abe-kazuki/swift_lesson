//
//  FirstViewController.swift
//  CNPS
//
//  Created by kazuki.abe on 2020/04/19.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController{

    @IBOutlet weak var talkTable: UITableView!
    @IBOutlet weak var chatTextField: UITextField!{
        didSet {

            chatTextField.delegate = self // デリゲートをセット
        }
    }
    @IBOutlet weak var send_button: UIImageView!
    @IBOutlet weak var tab_first: UITabBarItem!

    // UIButtonのインスタンスを作成する
    let button_yes = UIButton(type: UIButton.ButtonType.system)
    let button_no = UIButton(type: UIButton.ButtonType.system)
    
    // 現在日時を取得
    let now = Date()
    let dateFormatter = DateFormatter()
     
    private var timeLine = [""]
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mainScreenwidth = UIScreen.main.bounds.size.width
        let tabBarController: UITabBarController = UITabBarController()
        let tabBarHieght = tabBarController.tabBar.frame.size.height
        
        //はじめに表示させる年月日を取得
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        timeLine = ["結月ゆかり：\(dateFormatter.string(from: now))"]
        
        //時刻に設定変更
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        
        //テキストフィールドの設定
        self.chatTextField.borderStyle = .roundedRect
        self.chatTextField.borderStyle = UITextField.BorderStyle.roundedRect
        let blank_size = mainScreenwidth/12
        self.chatTextField.frame = CGRect(x:blank_size,y:self.view.frame.size.height-2*tabBarHieght,width: mainScreenwidth-2*blank_size-32, height: 34)
        self.view.addSubview(self.chatTextField)
        
        //送信画像の設定
        let right_chat_text = chatTextField.frame.origin.x + chatTextField.frame.size.width
        //配置はテキストフィールドの右部
        self.send_button.frame = CGRect(x:right_chat_text,y:self.view.frame.size.height-2 * tabBarHieght,width: 32, height: 34)
        send_button.isUserInteractionEnabled = false
        send_button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FirstViewController.sendImageViewTapped(_:))))
                
        // 「はい」「いいえ」ボタンの設定
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
        
        //配置はテキストフィールドの上部
        button_yes.layer.position = CGPoint(x: self.view.frame.width/5, y:self.chatTextField.frame.origin.y-button_yes.frame.height/2-4)
        button_no.layer.position = CGPoint(x: 2*self.view.frame.width/5, y:self.chatTextField.frame.origin.y-button_yes.frame.height/2-4)
        
        button_yes.addTarget(self, action:#selector( pussYesNoButton(_:)), for: UIControl.Event.touchUpInside)
        button_no.addTarget(self, action:#selector( pussYesNoButton(_:)), for: UIControl.Event.touchUpInside)

        self.view.addSubview(button_yes)
        self.view.addSubview(button_no)
        
        //tableviewの設定
        talkTable.delegate = self
        talkTable.dataSource = self
        talkTable.register(UINib(nibName: "ChatTableViewCell", bundle: nil) , forCellReuseIdentifier: cellId)
        talkTable.backgroundColor = UIColor(red:118/255,green:140/255,blue:180/255,alpha:1.0)
        //tableviewの高さをyesボタンの上までにする
        talkTable.frame.size = CGSize(width: mainScreenwidth, height: button_yes.frame.midY - 1.2*talkTable.frame.minY)
    }
    
    private func yukariLines(){
        let yukariSerifu = ["何？","こんにちは","今日も良い天気だね","ありがとう","別のこと話して！"]

        self.timeLine += ["結月ゆかり：\(yukariSerifu.randomElement() ?? "ごめん聞こえなかった")"]
        self.talkTable.reloadData()
        self.talkTable.scrollToRow(at: IndexPath(row: self.timeLine.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    @objc func sendImageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let chat = chatTextField.text else{
            return
        }
        chatTextField.text = ""
        self.timeLine += [chat]
        yukariLines()
    }
    
    @objc func pussYesNoButton(_ senfer: UIButton) {
        self.timeLine += [senfer.title(for: .normal)!]
        yukariLines()
    }

}
extension FirstViewController:  UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeLine.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatTableViewCell
        // セルに表示する値を設定する
        cell.messageText = self.timeLine[indexPath.row]
        //cell.timeLabel.text = self.time[indexPath.row]
        
        tableView.separatorStyle = .none
        return cell
    }


}

extension FirstViewController: UITextFieldDelegate{
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        self.configureObserver()

    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        self.removeObserver() // Notificationを画面が消えるときに削除
    }

    // Notificationを設定
    func configureObserver() {

        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // Notificationを削除
    func removeObserver() {

        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }

    // キーボードが現れた時に、画面全体をずらす。
    @objc func keyboardWillShow(notification: Notification?) {

        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform

        })
    }

    // キーボードが消えたときに、画面を戻す
    @objc func keyboardWillHide(notification: Notification?) {

        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in

            self.view.transform = CGAffineTransform.identity
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder() // Returnキーを押したときにキーボードを下げる
        return true
    }
    
    //テキストフィールド空欄時は送信できない様にする
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let chatField = self.chatTextField.text else{return}
        if chatField.isEmpty{
            send_button.isUserInteractionEnabled = false
        }
        else{
            send_button.isUserInteractionEnabled = true
        }
    }
}
