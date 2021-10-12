//
//  ViewController.swift
//  MyCalculator
//
//  Created by 苏颖康 on 2021/10/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLabel.text! = "0"
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var displayLabel: UILabel!
    
    var digitOnDisplay: String {
        get {
            return self.displayLabel.text!
        }
        
        set {
            self.displayLabel.text! = newValue
        }
    }
    
    var inTypingMode = false
    var isFloat = false
    let calculator = Calculator()
    
    @IBAction func numberTouched(_ sender: UIButton) {
        //print("Number \(sender.currentTitle!) touched")
        if sender.currentTitle == "." {
            if isFloat {
                return
            }
            else {
                isFloat = true
            }
        }
        if inTypingMode {
            digitOnDisplay = digitOnDisplay + sender.currentTitle!
        } else {
            digitOnDisplay = sender.currentTitle!
            inTypingMode = true
        }
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        //print("Operator \(sender.currentTitle!) touched")
        if let op = sender.currentTitle{
            if digitOnDisplay == "."{
                digitOnDisplay = "0"
            }
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
            }
            inTypingMode = false
            isFloat = false
        }
    }
}

