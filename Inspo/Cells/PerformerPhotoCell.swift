//
//  PerformerPhotoCell.swift
//  Inspo
//
//  Created by FDC-Macmini06 on 1/29/21.
//

import UIKit
import Kingfisher
import Foundation

class PerformerPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var performerImage: UIImageView!
    @IBOutlet weak var newbieBadge: UIImageView!
    

//    var gradientLayer: CAGradientLayer!


    
    var performer: Performer! {

        didSet {
//            self.performerImage.setImage(imageUrl: self.performer.performerImage)
//            self.performerImage.createGradientLayer()
//            self.nameLabel.text = self.performer.performerName

//            self.newbieBadge.image = self.performer.isNewbie ? #imageLiteral(resourceName: "shoshinsha-mark") : #imageLiteral(resourceName: "star")
//            self.onlineBadge.tintColor = self.performer.wasRecentOnline ? .green : .gray
//            createGradientLayer()
        }
    }
    
    
    
}

//extension UIImageView {
//
//    func setImage(imageUrl: String) {
//
//        self.kf.setImage(with: URL(string: imageUrl))
//    }
//
//}


//extension UIView {
//    
//    func createGradientLayer() {
//        let gradientLayer : CAGradientLayer! = CAGradientLayer()
//        
//        gradientLayer.colors = [
//            UIColor.clear.cgColor,
//            UIColor.black.cgColor
//            ]
//        gradientLayer.locations = [0.75,0.9]
//        gradientLayer.frame = bounds
//        self.layer.addSublayer(gradientLayer)
//    }
//}
