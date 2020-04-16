//
//  ViewController.swift
//  Calculator
//
//  Created by kazuki.abe on 2020/04/15.
//  Copyright © 2020 kazuki.abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!

    
    @IBOutlet weak var label1: UILabel!
    
    
    var operator1: String = "+"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label1.text = "0"
    }
    
    @IBAction func changevalue(_ sender: UISegmentedControl) {
        var segment1: String {
            switch sender.selectedSegmentIndex{
            case 0:
                return "+"
            case 1:
                return "-"
            case 2:
                return "*"
            case 3:
                return "/"
            default:
                return "該当無し"
            }
        }
        operator1 = segment1
    }
    
    
    
    @IBAction func pressbutton(_ sender: Any) {
        let num1 = (textfield1.text! as NSString).integerValue
        let num2 = (textfield2.text! as NSString).integerValue
        
        var result = 0
        print(result)
        
        switch operator1 {
        case "+":
            result = num1 + num2
            break
        case "-":
            result = num1 - num2
            break
        case "*":
            result = num1 * num2
            break
        case "/":
            result = num1 / num2
            break
        default:
            break
        }
        
        label1.text = "結果：\(result)"
    }
 
 }
