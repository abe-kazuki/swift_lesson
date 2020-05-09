//
//  ChatTableViewCell.swift
//  CNPS
//
//  Created by kazuki.abe on 2020/04/29.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {    
    //相手のUI設定
    @IBOutlet weak var agentImageView: UIImageView!
    @IBOutlet weak var agentMessageTextView: UITextView!
    @IBOutlet weak var agentTimeLabel: UILabel!
    @IBOutlet weak var agentNameLabel: UILabel!
    @IBOutlet weak var agentMessageTextViewWidth: NSLayoutConstraint!
    //自分のUI設定
    @IBOutlet weak var myMessageTextView: UITextView!
    @IBOutlet weak var myTimeLabel: UILabel!
    @IBOutlet weak var freshmanLabel: UILabel!
    @IBOutlet weak var myMessageTextViewWidth: NSLayoutConstraint!
    
    var messageText: String?{
        didSet{
            guard let text = messageText else {
                return
            }

            let width = estimateFrameForTextView(text: text).width + 20
            checkYukari(text: text,width: width)
        }
    }
    
    //文字列を調べてチャットUIの表示/非表示を切り替える
    private func checkYukari(text: String,width: CGFloat){
        var inputText = text
        if let range = text.range(of: "結月ゆかり：") {
            inputText.replaceSubrange(range, with: "")
            
            myMessageTextView.isHidden = true
            freshmanLabel.isHidden = true
            myTimeLabel.isHidden = true
            
            agentMessageTextView.isHidden = false
            agentImageView.isHidden = false
            agentNameLabel.isHidden = false
            agentTimeLabel.isHidden = false
            agentMessageTextView.text = inputText
            agentMessageTextViewWidth.constant = width - 70
        }
        else{
            myMessageTextView.isHidden = false
            freshmanLabel.isHidden = false
            myTimeLabel.isHidden = false
            myMessageTextView.text = inputText
            myMessageTextViewWidth.constant = width
            
            agentMessageTextView.isHidden = true
            agentImageView.isHidden = true
            agentNameLabel.isHidden = true
            agentTimeLabel.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red:118/255,green:140/255,blue:180/255,alpha:1.0)
        
        agentImageView.layer.cornerRadius = 30
        agentMessageTextView.layer.cornerRadius = 15
        agentTimeLabel.textColor = UIColor(red:1,green:1,blue:1,alpha:1.0)
        
        myMessageTextView.layer.cornerRadius = 15
        myMessageTextView.backgroundColor = UIColor(red:154/255,green:224/255,blue:97/255,alpha:1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func estimateFrameForTextView(text: String)->CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
    }
}
