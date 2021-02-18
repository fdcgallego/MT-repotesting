//
//  PerformerCollectionViewCell.swift
//  Inspo
//
//  Created by FDC-Macmini06 on 2/2/21.
//

import UIKit

class PerformerCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var performerImage: UIImageView!
    @IBOutlet weak var performerName: UILabel!
    @IBOutlet weak var performerArea: UILabel!
    @IBOutlet weak var performerStrength: UILabel!
    @IBOutlet weak var performerAge: UILabel!
    
    @IBOutlet weak var newbieBadge: UIImageView!
    @IBOutlet weak var onlineBadge: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.gradientView.createGradientLayer(
//            colors: [
//                UIColor.clear.cgColor,
//                UIColor.black.cgColor
//            ])
        
    }

    var performer: Performer! {
        
        didSet {
            self.performerImage.setImage(imageUrl: self.performer.performerImage)
            self.performerName.text = self.performer.performerName
            self.performerName.sizeToFit()
            self.performerAge.text = self.performer.performerAge > 0 ? String(self.performer.performerAge) : ""
            
            self.performerArea.text = self.performer.performerArea
            self.performerStrength.text = self.performer.performerStrength
            self.performerStrength.sizeToFit()
            
            self.newbieBadge.image = self.performer.isNewbie ? #imageLiteral(resourceName: "shoshinsha-mark") : #imageLiteral(resourceName: "star")
            self.onlineBadge.tintColor = self.performer.wasRecentOnline ? .green : .gray        
        }
    }
}


extension UIImageView {
    
    func setImage(imageUrl: String) {
        
        self.kf.setImage(with: URL(string: imageUrl))
    }

}
