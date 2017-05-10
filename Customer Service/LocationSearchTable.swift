//
//  LocationSearchTable.swift
//  Customer Service
//
//  Created by masterUNG on 5/5/2560 BE.
//  Copyright © 2560 EWTC. All rights reserved.
//

import UIKit

class LocationSearchTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
    
    
        return 1
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Top row"
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LocatinSearchTable OK")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
