//
//  HomeTableViewCell.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak private var btnTitle : UIButton!
    @IBOutlet weak private var lblTitle : UILabel!
    
    var objBE : BalanceResumenBE!{
        didSet{
            self.lblTitle.text = self.objBE.totdes
            self.btnTitle.setTitle(self.objBE.totnet, for: .normal)
            self.validate(color: self.objBE.tottip ?? "")
        }
    }
    
    func validate(color : String){
        if color == "N"{
            self.lblTitle.textColor = .black
            self.btnTitle.setTitleColor(.black, for: .normal)
        }else if color == "I"{
            self.lblTitle.textColor = .blue
            self.btnTitle.setTitleColor(.blue, for: .normal)
        }else{
            self.lblTitle.textColor = .red
            self.btnTitle.setTitleColor(.red, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
