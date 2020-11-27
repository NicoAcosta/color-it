//
//  ImageViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit
import Kingfisher


class ImageViewController : UIViewController {
    
    @IBOutlet weak var beforeImageView: UIImageView!
    
    @IBOutlet weak var afterImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var inputImageURL : String? = nil
    var outputImageURL : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.cornerRadius = 5
        beforeImageView.kf.setImage(with: URL(string: inputImageURL!))
        afterImageView.kf.setImage(with: URL(string: outputImageURL!))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: [violet, red])
    }
    
    convenience init(input: String, output: String) {
        self.init()
        inputImageURL = input
        outputImageURL = output
    }
    
    
    
    func getImages(beforeURL: String, afterURL: String) {
//        beforeImageView.kf.setImage(with: URL(string: beforeURL))
//        afterImageView.kf.setImage(with: URL(string: afterURL))
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let items = [beforeImageView.image, afterImageView.image]
        let share = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(share, animated: true)
        
    }
    
    
    
}
