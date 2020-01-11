//
//  DetailViewController.swift
//  FlagsHwS
//
//  Created by Heather Mason on 1/10/20.
//  Copyright © 2020 Heather Mason. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagImageView: UIImageView!
    var selectedFlag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.title = selectedFlag
        
        if let flagToLoad = selectedFlag {
            flagImageView.image = UIImage(named: flagToLoad)
            flagImageView.layer.borderWidth = 1
            flagImageView.layer.borderColor = UIColor.darkGray.cgColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareFlag() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, "Share this flag"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
