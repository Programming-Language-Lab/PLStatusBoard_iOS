//
//  MemberCollectionViewCell.swift
//  PLAttendance
//
//  Created by 이지훈 on 2023/05/15.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var memberImage: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backView.layer.cornerRadius = 12
    }

}
