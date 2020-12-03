//
//  DataCollection.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation
import UIKit
import InteractiveSideMenu


class DataCollectionVC : UIViewController, SideMenuItemContent, Storyboardable  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    var items : [ImageData]? = DataHelper.shared.items
    
    var imageDataForSegue : ImageData? = nil
    
    let myCellWidth = UIScreen.main.bounds.width / 2
    
    @IBOutlet weak var topView: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        topView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: "DataCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DataCollectionCell")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer(colors: [red, violet, violet])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAndRoload()
    }
    
    
    @IBAction func menuButtonAction(_ sender: Any) {
        showSideMenu()
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
        if indexPath.row == 0 || indexPath.row == 1 {
            cell!.topConstraint(constant: 50)
            self.updateViewConstraints()
        }
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
            imageVC.sender = self
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
        if indexPath.row == 0 || indexPath.row == 1 {
            return CGSize(width: myCellWidth, height: myCellWidth * 1.2 + 20)
        }
        
        return CGSize(width: myCellWidth, height: myCellWidth * 1.2)
    }
    
}
