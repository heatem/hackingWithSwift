//
//  ViewController.swift
//  FlagsHwS
//
//  Created by Heather Mason on 1/8/20.
//  Copyright © 2020 Heather Mason. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Flags"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            let imageName = item.components(separatedBy: "@")
            if let country = imageName.first, item.hasSuffix(".png"), !countries.contains(imageName[0]) {
                countries.append(country)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(named: "\(countries[indexPath.row])", in: nil, with: nil)
        cell.imageView?.layer.borderWidth = 0.5
        cell.imageView?.layer.borderColor = UIColor.darkGray.cgColor
        cell.textLabel?.text = "\(countries[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedFlag = countries[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

