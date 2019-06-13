//
//  TableViewController.swift
//  AlamofireSwiftyJson
//
//  Created by Andika on 13/06/19.
//  Copyright © 2019 Andika. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var array = [[String:AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        
        let baseUrl = "https://development.mrandika.space/api/"
        let type = ["popular/"]
        let key = ["apiKey"]
        
        let url = baseUrl + type[0] + key[0]
        
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                // print(swiftyJsonVar)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.array = resData as! [[String:AnyObject]]
                }
                
                if self.array.count > 0 {
                    self.tableView.reloadData()
                }
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = table.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath)
        
        var dict = array[indexPath.row]

        cell.textLabel?.text = dict["name"] as? String
        let price: Int = dict["price"] as! Int
        cell.detailTextLabel?.text = "Rp. " + String(price)
        return cell
    }

}
