/*
 MIT License
 
 Copyright (c) 2018 NUM Technology Ltd
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  ParseTestViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import UIKit
import MODL_Interpreter

class ParseTestViewController: UIViewController {

    @IBOutlet weak var inputModlField: UITextView!
    @IBOutlet weak var resultView: UITextView!
    /*
     //basic pair
     testKey=testValue
     
     //group of pairs
     one=1;two=2;three=3
     
     //basic array
     test=[zero;one]
     
     // multiple pairs
     one=1;two=2;three=3
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didPressTest1(_ sender: Any) {
        inputModlField.text = "testKey=testValue"
        didPressSubmit(sender)
    }

    @IBAction func didPressTest2(_ sender: Any) {
        inputModlField.text = "one=1;two=2;three=3"
        didPressSubmit(sender)
    }

    @IBAction func didPressTest3(_ sender: Any) {
        inputModlField.text = "test=[zero;one]"
        didPressSubmit(sender)
    }

    @IBAction func didPressTest4(_ sender: Any) {
        inputModlField.text = ""
        didPressSubmit(sender)
    }
    
    @IBAction func didPressSubmit(_ sender: Any) {
        guard let modl = inputModlField.text else {
            resultView.text = "Enter MODL to test"
            return
        }
        let p = Interpreter()
        do {
            let result = try p.parseToJson(modl)
            resultView.text = result
        } catch {
            print("Parse error: \(error)")
        }
    }
}
