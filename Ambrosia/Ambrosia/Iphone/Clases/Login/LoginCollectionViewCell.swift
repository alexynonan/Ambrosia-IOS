//
//  LoginCollectionViewCell.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var lblName : UILabel!
    
    var objBE : UserBE!{
        didSet{
            self.lblName.text = self.objBE.usunam
        }
    }
    
}
