//
//  ChatTableViewCell.swift
//  CNPS
//
//  Created by kazuki.abe on 2020/04/29.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {    

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var myMessageTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var myTimeLabel: UILabel!
    @IBOutlet weak var yukariLabel: UILabel!
    @IBOutlet weak var freshmanLabel: UILabel!
    @IBOutlet weak var messageTextViewWidth: NSLayoutConstraint!
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
    
    private func checkYukari(text: String,width: CGFloat){
        var inputText = text
        if let range = text.range(of: "結月ゆかり：") {
            myMessageTextView.isHidden = true
            messageTextView.isHidden = false
            userImageView.isHidden = false
            yukariLabel.isHidden = false
            freshmanLabel.isHidden = true
            timeLabel.isHidden = false
            myTimeLabel.isHidden = true
            
            inputText.replaceSubrange(range, with: "")
            messageTextView.text = inputText
            messageTextViewWidth.constant = width - 70
        }
        else{
            myMessageTextView.isHidden = false
            messageTextView.isHidden = true
            userImageView.isHidden = true
            yukariLabel.isHidden = true
            freshmanLabel.isHidden = false
            timeLabel.isHidden = true
            myTimeLabel.isHidden = false
            
            myMessageTextView.text = inputText
            myMessageTextViewWidth.constant = width
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red:118/255,green:140/255,blue:180/255,alpha:1.0)
        
        userImageView.layer.cornerRadius = 30
        messageTextView.layer.cornerRadius = 15
        
        myMessageTextView.layer.cornerRadius = 15
        myMessageTextView.backgroundColor = UIColor(red:154/255,green:224/255,blue:97/255,alpha:1.0)
        
        timeLabel.textColor = UIColor(red:1,green:1,blue:1,alpha:1.0)
        
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
