//
//  DNSTestViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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
