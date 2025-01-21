//
//  ViewController.swift
//  Homework14
//
//  Created by Ruslan Liulka on 20.01.2025.
//

import UIKit

enum ConstantLink: String {
    case threeItems = "https://api.restful-api.dev/objects?id=3&id=5&id=10"
    case oneItem = "https://api.restful-api.dev/objects/7"
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var devices: [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    @IBAction func threeItemsButtonAction(_ sender: Any) {
        //getDataFromLink(link: .threeItems)
        fetchData(urlString: .threeItems, type: [Device].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.devices = success
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    @IBAction func OneItemButtonAction(_ sender: Any) {
        //getDataOneItem(link: .oneItem)
        fetchData(urlString: .oneItem, type: Device.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.devices.append(success)
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func getDataFromLink(link: ConstantLink) {
        
        guard let url = URL(string: link.rawValue) else {
            assertionFailure("Unnable to make url from string \(link.rawValue)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let responseError = error {
                assertionFailure("Get error: \(responseError)")
            }
            
            guard let responseData = data else {
                assertionFailure("Unnable to get data")
                return
            }
            
            do {
                let decodedDevice = try JSONDecoder().decode([Device].self, from: responseData)
                DispatchQueue.main.async {
                    self.devices = decodedDevice
                    print(decodedDevice)
                    self.tableView.reloadData()
                    
                    
                }
                
            } catch(let parseError) {
                print(parseError)
            }
 
            
        }
        task.resume() 
        
    }
    
    func getDataOneItem(link: ConstantLink) {
        
        guard let url = URL(string: link.rawValue) else {
            assertionFailure("Unnable to make url from string \(link.rawValue)")
            return
        }
        
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let responseError = error {
                assertionFailure("Get error: \(responseError)")
            }
            
            guard let responseData = data else {
                assertionFailure("Unnable to get data")
                return
            }
            
            do {
                
                let responseDevice = try JSONDecoder().decode(Device.self, from: responseData)
                
                DispatchQueue.main.async {
                    self.devices.append(responseDevice)
                    self.tableView.reloadData()
                }
                
            } catch(let parseError) {
                print(parseError)
            }
        }
    
        task.resume()
        
    }
}


struct Device: Decodable {
    let id: String
    let name: String
    let details: DeviceDetails
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case details = "data"
    }
}

struct DeviceDetails: Decodable {
    let color: String?
    let capacityGb: Int?
    let price: Double?
    let capacity: String?
    let screenSize: Double?
    
    enum CodingKeys: String, CodingKey {
        case color
        case capacityGb = "capacity GB"
        case price = "price"
        case capacity = "Capacity"
        case screenSize = "Screen size"
    }
}
