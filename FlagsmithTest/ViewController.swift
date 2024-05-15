//
//  ViewController.swift
//  FlagsmithTest
//
//  Created by Maulana Frasha on 13/05/24.
//

import UIKit
import FlagsmithClient

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        Flagsmith.shared.getFeatureFlags { result in
            switch result {
            case .success(let success):
                print("\nGet Feature Flags by Identity userTest: ", success)
                for flag in success {
                    DispatchQueue.main.async {
                        if flag.feature.name == "collectionview" {
                            self.collectionView.isHidden = !flag.enabled
                        } else {
                            self.tableView.isHidden = !flag.enabled
                        }
                    }
                }
            case .failure(let failure):
                print("Feature Flags Error: ", failure)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Test Flagsmith"
        title = "Flagsmith"
        title = "Flagsmith"
        
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func nextViewController(_ sender: Any) {
        let viewController = UIViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        return reusableCell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reausableCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        return reausableCollection
    }
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage(systemName: "homekit")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
    }
}

