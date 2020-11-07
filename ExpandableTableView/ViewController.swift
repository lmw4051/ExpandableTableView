//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by David on 2020/11/7.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  let cellId = "cellId"
  
  let names = [
    "Amy", "Bill", "Zack", "Steve", "Jack"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Contacts"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let name = self.names[indexPath.row]
    cell.textLabel?.text = name
    return cell
  }
}
