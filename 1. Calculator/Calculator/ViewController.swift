//
//  ViewController.swift
//  Calculator
//
//  Created by Andrew Breckenridge on 5/19/15.
//  Copyright (c) 2015 Andrew Breckenridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!

    var opStack: [Double] = []
    var userIsTyping = false
    
    
    @IBAction func hitNumber(sender: UIButton) {
        let number = sender.currentTitle!
        
        if userIsTyping {
            displayLabel.text! += number
        } else {
            displayLabel.text = number
            userIsTyping = true
        }
    }
    
    @IBAction func hitEnter() {
        if userIsTyping {
            opStack.append(Double(displayLabel.text!.toDouble()!))
            operationLabel.text! += "\(displayLabel.text!) "
            
            userIsTyping = false
        }
    }
    
    @IBAction func hitOperator(sender: UIButton) {
        hitEnter()
        
        func operate(operation: (Double, Double) -> Double) {
            if opStack.count >= 2 {
                hitEnter()
                opStack.append(operation(opStack.removeLast(), opStack.removeLast()))
                displayLabel.text = "\(opStack.last!)"
                operationLabel.text! += "\(sender.titleLabel!.text!) \(opStack.last!) "
            }
        }
        
        switch sender.titleLabel!.text! {
        case "+": operate({ $0 + $1 })
        case "-": operate({ $1 - $0 })
        case "✕": operate({ $0 * $1 })
        case "÷": operate({ $1 / $0 }) 
        default: break
        }
    }
    
    @IBAction func hitDecimal() {
        if userIsTyping {
            if displayLabel.text!.rangeOfString(".") == nil {
                displayLabel.text! += "."
            }
        } else {
            displayLabel.text = "0."
            userIsTyping = true
        }
    }
    
    @IBAction func hitTrig(sender: UIButton) {
        func operate(operation: Double -> Double) {
            if opStack.count >= 1 {
                hitEnter()
                opStack.append(operation(opStack.removeLast()))
                displayLabel.text = "\(opStack.last!)"
                operationLabel.text = "\(sender.titleLabel!.text!)"
            }
            operate(<#operation: Double -> Double##Double -> Double#>)
        }
        
        switch sender.titleLabel!.text! {
        case "sin": operate({ sin($0) })
        case "cos": operate({ sin($0) })
        case "√": operate({ sqrt($0) })
        case "π": operate({ ($0 - $0) + M_PI })
        default: break
        }
    }
    
    @IBAction func hitReset() {
        opStack = []
        displayLabel.text = "0"
        operationLabel.text = ""
    }
}