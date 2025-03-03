//
//  Extension.swift
//  Homework14
//
//  Created by Ruslan Liulka on 20.01.2025.
//


import UIKit

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UITableViewCell else {
            return UITableViewCell()
        }
        
        let device = devices[indexPath.row]
        
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.numberOfLines = 0
        
        var detailText = ""
        
        
        if let color = device.details.color {
            detailText += "Color: \(color)\n"
        }
        
        if let capacity = device.details.capacity {
            detailText += "Capacity: \(capacity)\n"
        }
        
        if let capacityGb = device.details.capacityGb {
            detailText += "Capacity: \(capacityGb) GB\n"
        }
        
        if let price = device.details.price {
            detailText += "Price: \(price)\n"
        }
        
        if let screenSize = device.details.screenSize {
            detailText += "Screen Size: \(screenSize)n"
        }
        
        cell.detailTextLabel?.text = detailText
        
        return cell
    }
    
    
}
