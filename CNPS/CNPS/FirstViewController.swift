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
    
    @IBOutlet weak var firstUiTabBar: UITabBarItem!
    @IBOutlet weak var chat_text: UITextField!{
        didSet {

            chat_text.delegate = self // デリゲートをセット
        }
    }
    @IBOutlet weak var send_button: UIImageView!
    
    private var chat = "入力してね"
    @IBOutlet weak var tab_first: UITabBarItem!

    // UIButtonのインスタンスを作成する
    let button_yes = UIButton(type: UIButton.ButtonType.system)
    let button_no = UIButton(type: UIButton.ButtonType.system)
    
    // 現在日時を取得
    let now = Date()
    let dateFormatter = DateFormatter()

    
    var timeLine = [""]
    var time = [""]
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let mainScreenwidth = UIScreen.main.bounds.size.width
        
        let tabBarController: UITabBarController = UITabBarController()
        let tabBarHieght = tabBarController.tabBar.frame.size.height
        
        talkTable.delegate = self
        talkTable.dataSource = self
        talkTable.register(UINib(nibName: "ChatTableViewCell", bundle: nil) , forCellReuseIdentifier: cellId)
        talkTable.backgroundColor = UIColor(red:118/255,green:140/255,blue:180/255,alpha:1.0)
        
        //はじめに表示させる年月日を取得
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        timeLine = ["結月ゆかり：\(dateFormatter.string(from: now))"]
        
        //はじめに表示させる時間取得に設定を更新
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        time = [dateFormatter.string(from: now)]
        
        //テキストフィールドの設定
        self.chat_text.borderStyle = .roundedRect
        
        let blank_size = mainScreenwidth/12
        
        self.chat_text.borderStyle = UITextField.BorderStyle.roundedRect
        
        self.chat_text.frame = CGRect(x:blank_size,y:self.view.frame.size.height-2*tabBarHieght,width: mainScreenwidth-2*blank_size-32, height: 34)
       
        self.view.addSubview(self.chat_text)
        
        let right_chat_text = chat_text.frame.origin.x + chat_text.frame.size.width
        
        //送信画像の設定
        self.send_button.frame = CGRect(x:right_chat_text,y:self.view.frame.size.height-2 * tabBarHieght,width: 32, height: 34)
        send_button.isUserInteractionEnabled = false

        
        send_button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FirstViewController.imageViewTapped(_:))))
        
        
        // 「はい」「いいえ」ボタンの設定
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
        
        //tableviewの高さをyesボタンの上までにする
        talkTable.frame.size = CGSize(width: mainScreenwidth, height: button_yes.frame.midY - 1.2*talkTable.frame.minY)
    }
    
    private func yukariLines(){
        let yukariSerifu = ["何？","こんにちは","今日も良い天気だね","ありがとう","別のこと話して！"]

        self.timeLine += ["結月ゆかり：\(yukariSerifu.randomElement() ?? "ごめん聞こえなかった")"]
        self.talkTable.reloadData()
        self.talkTable.scrollToRow(at: IndexPath(row: self.timeLine.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    // 画像がタップされたら呼ばれる
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let chat = chat_text.text else{
            return
        }
        chat_text.text = ""
        self.timeLine += [chat]
        self.time += [dateFormatter.string(from: now)]
        
        yukariLines()
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func pussYesNoButton(_ senfer: UIButton) {
        self.timeLine += [senfer.title(for: .normal)!]
        self.time += [dateFormatter.string(from: now)]
        
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
    
    //空欄時は送信できない様に
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let chatField = self.chat_text.text else{return}
        if chatField.isEmpty{
            send_button.isUserInteractionEnabled = false
        }
        else{
            send_button.isUserInteractionEnabled = true
        }
    }
}
