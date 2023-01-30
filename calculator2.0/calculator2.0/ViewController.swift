//
//  ViewController.swift
//  calculator2.0
//
//  Created by Dmytro on 12.01.2023.
//

import UIKit

class ViewController: UIViewController {

    var numberFromScreen:Double = 0;
    var firstNum:Double = 0;
    var mathSign:Bool = false;
    var operation:Int = 0;
    var dotIsPlaced = false;
    var stillTyping = false;
    @IBOutlet weak var result: UILabel!
    
    var currentInput: Double {
        get {
            return Double(result.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                result.text = "\(valueArray[0])"
            } else {
                result.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func digits(_ button: UIButton) {
        if (mathSign == true) {
            result.text = String(button.tag)
            mathSign = false
            stillTyping = true
        }
        else {
            if stillTyping {
            result.text = result.text! + String(button.tag)
            }
            else {
                result.text = String(button.tag)
                stillTyping = true
            }
        }
        numberFromScreen = currentInput
    }
    
    @IBAction func buttons(_ button: UIButton) {
        if result.text != "" && button.tag != 10 && button.tag != 15 && button.tag != 18{
            firstNum = currentInput
            operation = button.tag
            mathSign = true
            dotIsPlaced = false
        }
    }
    
    @IBAction func mathOperations(_ buttons: UIButton){
        if operation == 11 {
            if firstNum == 0 || numberFromScreen == 0 {
                result.text = "Не определено"
            } else {
                currentInput = firstNum / numberFromScreen
            }
        }
        else if operation == 12 {
            currentInput = firstNum * numberFromScreen
        }
        else if operation == 13 {
            currentInput = firstNum - numberFromScreen
        }
        else if operation == 14 {
            currentInput = firstNum + numberFromScreen
        }
        dotIsPlaced = false
    }
    
    @IBAction func removeButton(_ buttons: UIButton){
        result.text = ""
        firstNum = 0
        numberFromScreen = 0
        operation = 0
        dotIsPlaced = false
    }
    
    @IBAction func plusMinusButton(_ buttons: UIButton) {
        numberFromScreen = currentInput * -1
        if !result.text!.contains("-") {
            result.text = "-" + result.text!
        }
        else if result.text!.contains("-") {
            currentInput = numberFromScreen
        }
        dotIsPlaced = true
    }
    
    @IBAction func percentButton(_ buttons: UIButton) {
        if firstNum != 0 {
        numberFromScreen = firstNum * numberFromScreen / 100
        } else {
        currentInput = numberFromScreen / 100
        }
    }
    
    @IBAction func dotButton(_ buttons: UIButton) {
        if stillTyping && !dotIsPlaced {
            result.text = result.text! + "."
            dotIsPlaced = true
            mathSign = false
        }
        else if !stillTyping && !dotIsPlaced{
            result.text = "0."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

