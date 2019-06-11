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
//  DNSTestViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import UIKit

class DNSTestViewController: UIViewController {

    @IBOutlet weak var domainField: UITextField!
    @IBOutlet weak var resultView: UITextView!
    var cumulativeResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        domainField.text = "nominet.org.uk"
    }

    @IBAction func didPressSubmit(_ sender: Any) {
        cumulativeResult = ""
        guard let domain = domainField.text else {
            resultView.text = "Please enter a domain"
            return
        }
        DNSTxtRecord.lookup(domain) { (result) in
            var output: String = ""
            for (k,v) in result ?? [:] {
                output += "\(k): \(v) \n\n"
            }
            self.cumulativeResult += output
        }
        self.resultView.text = cumulativeResult
    }
}
