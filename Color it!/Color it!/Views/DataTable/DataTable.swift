//
//  DataTable.swift
//  Color it!
//
//  Created by Nicolás Acosta on 29/11/2020.
//

import Foundation
import UIKit


class DataTableVC : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = DataHelper.shared.context
    
    var items : [ImageData]? = nil
    
    var imageDataForSegue : ImageData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataHelper.shared.fetch()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        items = DataHelper.shared.items
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToImageViewer" {
            let imageVC = segue.destination as! ImageViewerVC
            imageVC.imageData = imageDataForSegue
        }
        
    }
    
}



extension DataTableVC : UITableViewDelegate {
    
}



extension DataTableVC : UITableViewDataSource {
    
    func fetchAndRoload() {
        DataHelper.shared.fetch()
        //  items   =   datahelper.shared.items ???
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let item = (DataHelper.shared.items)![indexPath.row]
        let item = items![indexPath.row]
        
        imageDataForSegue = item
        imageViewerSegue()
        imageDataForSegue = nil
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "ItemCell")
        }
        
        let item = items![indexPath.row]
        
        cell!.textLabel?.text = item.name
        return cell!
        
    }
    
    
}
