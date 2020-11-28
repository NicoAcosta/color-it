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
    
    @IBOutlet weak var beforeImageView: UIImageView!
    
    @IBOutlet weak var afterImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var imageData : ImageData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.cornerRadius = 5
        beforeImageView.image = imageData?.preImage
        afterImageView.image = imageData?.postImage
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: [violet, red])
    }
    /*
    convenience init(input: String, output: String) {
        self.init()
        inputImageURL = input
        outputImageURL = output
    }
    */
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let items = [beforeImageView.image, afterImageView.image]
        let share = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(share, animated: true)
    }
    
    
    
}
