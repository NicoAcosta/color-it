//
//  DataCollection.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation
import UIKit


class DataCollectionVC : UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items : [ImageData]? = DataHelper.shared.items
    
    var imageDataForSegue : ImageData? = nil
    
    let myCellWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "DataCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DataCollectionCell")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer(colors: [violet, blue])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAndRoload()
    }
    
    
    
    
    
    
}

extension DataCollectionVC : UICollectionViewDataSource {
    
    func fetchAndRoload() {
        DataHelper.shared.fetch()
        items = DataHelper.shared.items
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCollectionCell", for: indexPath) as? DataCollectionCell
        let item = items![indexPath.row]
        cell!.loadData(item)
        
        return cell!
    }
    
}

extension DataCollectionVC : UICollectionViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToImageViewer" {
            let imageVC = segue.destination as! ImageViewerVC
            imageVC.imageData = imageDataForSegue
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = items![indexPath.row]
        
        imageDataForSegue = item
        imageViewerSegue()
        imageDataForSegue = nil
        
        
    }
    
}


extension DataCollectionVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth * 1.2)
    }
    
}
