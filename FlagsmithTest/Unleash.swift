//
//  Unleash.swift
//  FlagsmithTest
//
//  Created by Maulana Frasha on 15/05/24.
//

import UIKit
import UnleashProxyClientSwift

class Unleash: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        let unleash = UnleashClient(
            unleashUrl: "https://app.unleash-hosted.com/demo/api/frontend",
            clientKey: "UnleashTest:development.3e833d3cc281bd4bea647da02edc1fe55b524516c12404bb90b3bbe8")
        unleash.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let collectionViewFeature = unleash.isEnabled(name: "collectionview")
            self.collectionView.isHidden = !collectionViewFeature
            print("collectionViewFeature: ", collectionViewFeature)
            
            let value = unleash.isEnabled(name: "testFeatureFlag")
            self.tableView.isHidden = !value
            print("tableViewFeature: ", value)
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

extension Unleash: UITableViewDelegate, UITableViewDataSource {
    
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

extension Unleash: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reausableCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! UnleashCollectionCell
        return reausableCollection
    }
}

class UnleashCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = UIImage(systemName: "homekit")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
    }
}
