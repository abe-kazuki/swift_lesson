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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yukariLabel: UILabel!
    @IBOutlet weak var messageTextViewWidth: NSLayoutConstraint!
    
    var messageText: String?{
        didSet{
            guard let text = messageText else {
                return
            }
            let width = estimateFrameForTextView(text: text).width + 20
            messageTextViewWidth.constant = width
            messageTextView.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(red:118/255,green:140/255,blue:180/255,alpha:1.0)
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width * 0.5
        messageTextView.layer.cornerRadius = 15
        
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
