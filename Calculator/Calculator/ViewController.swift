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
    
    var selected_operator: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label1.text = "0"
    }
    
    @IBAction func changevalue(_ sender: UISegmentedControl) {

        selected_operator = sender.selectedSegmentIndex
    }
    
    
    
    @IBAction func pressbutton(_ sender: Any) {
        let num1 = (textfield1.text! as NSString).integerValue
        let num2 = (textfield2.text! as NSString).integerValue
        
        var result = 0
        
        switch selected_operator {
        case 0:
            result = num1 + num2
            break
        case 1:
            result = num1 - num2
            break
        case 2:
            result = num1 * num2
            break
        case 3:
            result = num1 / num2
            break
        default:
            break
        }
        
        label1.text = "結果：\(result)"
    }
 
 }
