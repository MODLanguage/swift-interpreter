//
//  DemoOptionsViewController.swift
//  MODL-Swift
//
//  Created by Nicholas Jones on 17/04/2019.
//  Copyright © 2019 Touchsoft Ltd. All rights reserved.
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
