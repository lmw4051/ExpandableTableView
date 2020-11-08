//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by David on 2020/11/7.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  // MARK: - Property
  let cellId = "cellId"
  
  var twoDimensionalArray = [
    ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"]),
    ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"]),
    ExpandableNames(isExpanded: true, names: ["David", "Dan"]),
    ExpandableNames(isExpanded: true, names: ["Patrick", "Patty"]),
  ]
  
  var showIndexPaths = false
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    
    navigationItem.title = "Contacts"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }
  
  // MARK: - Selector Methods
  @objc func handleShowIndexPath() {
    print("Attemping reload animation of indexPaths...")
    
    var indexPathsToReload = [IndexPath]()
    
    for section in twoDimensionalArray.indices {
      for row in twoDimensionalArray[section].names.indices {
        print(section, row)
        let indexPath = IndexPath(row: row, section: section)
        indexPathsToReload.append(indexPath)
      }
    }
    
    showIndexPaths = !showIndexPaths
    
    let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : UITableView.RowAnimation.left
    
    tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
  }
  
  @objc func handleExpandClose(button: UIButton) {
    print("Trying to expand and close section...")
    let section = button.tag
    var indexPaths = [IndexPath]()
    
    for row in twoDimensionalArray[section].names.indices {
      print(0, row)
      let indexPath = IndexPath(row: row, section: section)
      indexPaths.append(indexPath)
    }
    
    let isExpanded = twoDimensionalArray[section].isExpanded
    twoDimensionalArray[section].isExpanded = !isExpanded
    
    button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
    
    if isExpanded {
      tableView.deleteRows(at: indexPaths, with: .fade)
    } else {
      tableView.insertRows(at: indexPaths, with: .fade)
    }
  }
  
  // MARK: - UITableView Delegate Methods
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let button = UIButton(type: .system)
    button.setTitle("Close", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .yellow
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
    button.tag = section
    
    return button
    
//    let label = UILabel()
//    label.text = "Header"
//    label.backgroundColor = UIColor.lightGray
//    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 34
  }
  
  // MARK: - UITableView DataSource Methods
  override func numberOfSections(in tableView: UITableView) -> Int {
    return twoDimensionalArray.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if !twoDimensionalArray[section].isExpanded {
      return 0
    }
    
    return twoDimensionalArray[section].names.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
    cell.textLabel?.text = name
    
    if showIndexPaths {
      cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
    }
    return cell
  }
}
