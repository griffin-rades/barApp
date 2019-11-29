//
//  BarTableViewController.swift
//  barApp
//
//  Created by Griffin Rades on 11/28/19.
//  Copyright © 2019 GriffinRades. All rights reserved.
//

import UIKit
import Firebase

class BarTableViewController: UITableViewController {

    var bars = [String]()
    var barsDict = [String:String]()
    let cellId = "barCell"
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        loadBars()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BarTableViewCell.")
        }
        
        let bar = bars[indexPath.row]
        
        cell.barNameLabel.text = bar
        
        return cell
    }
    
    private func loadBars(){
        ref.child("barNames").observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : String] ?? [:]
            self.bars.removeAll()
            
            for (_,value) in postDict{
                self.bars.append(value)
            }
            self.tableView.reloadData()
        })
    }
}
