//
//  Firebase.swift
//  FlagsmithTest
//
//  Created by Maulana Frasha on 15/05/24.
//

import UIKit
import FirebaseRemoteConfig

class Firebase: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(fromPlist: "remote_config_defaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { _, _ in  }
            } else {
              print("Config not fetched")
              print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
        
        let remoteValue = remoteConfig.configValue(forKey: "collectionview")
        print("\nFirebase Collection View feature: ", remoteValue.boolValue)
        if remoteValue.boolValue {
            DispatchQueue.main.async {
                self.collectionView.isHidden = remoteValue.boolValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension Firebase: UITableViewDelegate, UITableViewDataSource {
    
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

extension Firebase: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reausableCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! FirebaseCollectionCell
        return reausableCollection
    }
}

class FirebaseCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage(systemName: "homekit")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
    }
}

