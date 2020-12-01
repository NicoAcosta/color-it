//
//  DataCollectionCell.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import UIKit

class DataCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        postImageView.borders()
        
    }
    
    func loadData(_ imageData: ImageData?) {
        
        nameLabel.text = imageData?.name
        postImageView.image = UIImage(data: (imageData?.postImagePNG)!)
        
    }

}
