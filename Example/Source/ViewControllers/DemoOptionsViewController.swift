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
//  DemoOptionsViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//

import UIKit

class DemoOptionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private enum TableOption: Int, CaseIterable {
        case dns
        case parser
        
        var displayName: String {
            switch self {
            case .dns:
                return "DNS"
            case .parser:
                return "MODL Parser"
            }
        }
        
        var segueIdentifier: String {
            switch self {
            case .dns:
                return "toDNS"
            case .parser:
                return "toParser"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}


extension DemoOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = TableOption(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        let row = UITableViewCell(style: .default, reuseIdentifier: "tableCell")
        row.textLabel?.text = type.displayName
        return row
    }
}

extension DemoOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = TableOption(rawValue: indexPath.row) else {
            return
        }
        performSegue(withIdentifier: type.segueIdentifier, sender: nil)
    }
}
