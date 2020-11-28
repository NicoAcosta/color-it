//
//  ImageViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit
import Kingfisher


class ImageViewerVC : UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var preImageView: UIImageView!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var imageData : ImageData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.cornerRadius = 5
        nameLabel.text = imageData?.name
        preImageView.image = UIImage(data: (imageData?.preImagePNG)!)
        postImageView.image = UIImage(data: (imageData?.postImagePNG)!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: [violet, red])
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        shareImages()
    }
    
    
    
    func shareImages() {
        let items = [preImageView.image, postImageView.image]
        let share = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(share, animated: true)
    }
    
}
