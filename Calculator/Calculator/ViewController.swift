//
//  ViewController.swift
//  Calculator
//
//  Created by kazuki.abe on 2020/04/15.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum operatype: Int{
        case add = 0
        case sub = 1
        case mul = 2
        case div = 3
    }
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label1.text = "0"
        btn1.setTitle("計算開始" , for: .normal)
        btn1.addTarget(self, action: #selector(pressed_button(_:)), for: UIControl.Event.touchUpInside)

    }
    
    @objc func pressed_button(_ senfer: UIButton){
        let num1 = Int(textfield1.text!) ?? 0
        let num2 = Int(textfield2.text!) ?? 0

        var rerult: Int{
            switch segment.selectedSegmentIndex {
            case operatype.add.rawValue:
                return num1 + num2
            case operatype.sub.rawValue:
                return num1 - num2
            case operatype.mul.rawValue:
                return num1 * num2
            case operatype.div.rawValue where num2 != 0 :
                return num1 / num2
            default:
                return 0
            }
        }
        label1.text = "結果：\(rerult)"

    }

}
