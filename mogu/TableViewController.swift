//
//  TableViewController.swift
//  mogu
//
//  Created by Hanguang on 31/12/2016.
//  Copyright © 2016 Hanguang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var stringArray = ["A 加载中...", "B 加载中...", "C 加载中...", "D 加载中...", "E 加载中..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadItems()
    }
    
    func loadItems() {
        let workItem1 = DispatchWorkItem(qos: .userInitiated) {
            self.stringArray[0] = "A 加载完成"
            self.updateCellWithIndex(index: 0)
        }
        
        let workItem2 = DispatchWorkItem(qos: .userInitiated) {
            self.stringArray[1] = "B 加载完成"
            self.updateCellWithIndex(index: 1)
        }
        
        let workItem3 = DispatchWorkItem(qos: .userInitiated) {
            self.stringArray[2] = "C 加载完成"
            self.updateCellWithIndex(index: 2)
        }
        
        let workItem4 = DispatchWorkItem(qos: .userInitiated) {
            self.stringArray[3] = "D 加载完成"
            self.updateCellWithIndex(index: 3)
        }
        
        let workItem5 = DispatchWorkItem(qos: .userInitiated) {
            self.stringArray[4] = "E 加载失败"
            self.updateCellWithIndex(index: 4)
        }
        
        DispatchHelper.sharedInstance.tableViewQueue.asyncAfter(
            deadline: .now() + DispatchTimeInterval.seconds(Int(arc4random_uniform(10))), execute: workItem1
        )
            
        DispatchHelper.sharedInstance.tableViewQueue.asyncAfter(
            deadline: .now() + DispatchTimeInterval.seconds(Int(arc4random_uniform(10))), execute: workItem2
        )
        
        DispatchHelper.sharedInstance.tableViewQueue.asyncAfter(
            deadline: .now() + DispatchTimeInterval.seconds(Int(arc4random_uniform(10))), execute: workItem3
        )
        
        DispatchHelper.sharedInstance.tableViewQueue.asyncAfter(
            deadline: .now() + DispatchTimeInterval.seconds(Int(arc4random_uniform(5))), execute: workItem4
        )
        
        DispatchHelper.sharedInstance.tableViewQueue.asyncAfter(
            deadline: .now() + DispatchTimeInterval.seconds(Int(arc4random_uniform(5))), execute: workItem5
        )
    }
    
    func updateCellWithIndex(index: Int) {
        DispatchQueue.main.async {
            for cell in self.tableView.visibleCells {
                if let indexPath = self.tableView.indexPath(for: cell) {
                    if indexPath.row == index {
                        cell.textLabel?.text = self.stringArray[index]
                    }
                }
            }
        }
    }
    
    // MARK: - Button methods
    
    @IBAction func ReloadButtonTouched(_ sender: UIBarButtonItem) {
        stringArray = ["A 加载中...", "B 加载中...", "C 加载中...", "D 加载中...", "E 加载中..."]
        tableView.reloadData()
        loadItems()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stringArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.blue
        } else if indexPath.row == 1 {
            cell.backgroundColor = UIColor.orange
        } else if indexPath.row == 2 {
            cell.backgroundColor = UIColor.lightGray
        } else if indexPath.row == 3 {
            cell.backgroundColor = UIColor.red
        } else if indexPath.row == 4 {
            cell.backgroundColor = UIColor.black
        }
        
        return cell
    }
 
}
