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
    "Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"
  ]
  
  let cNames = [
    "Carl", "Chris", "Christina", "Cameron"
  ]
  
  let dNames = [
    "David", "Dan"
  ]
  
  let twoDimensionalArray = [
    ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"],
    ["Carl", "Chris", "Christina", "Cameron"],
    ["David", "Dan"],
    ["Patrick", "Patty"]
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Contacts"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.text = "Header"
    label.backgroundColor = UIColor.lightGray
    return label
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return twoDimensionalArray.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return twoDimensionalArray[section].count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let name = twoDimensionalArray[indexPath.section][indexPath.row]
    cell.textLabel?.text = name
    return cell
  }
}
