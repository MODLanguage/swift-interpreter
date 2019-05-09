//
//  ParseTestViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
//

import UIKit

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
        let p = ModlParser()
        do {
            let result = try p.parse(modl)
            resultView.text = result
        } catch {
            print("Parse error: \(error)")
        }
    }
}
