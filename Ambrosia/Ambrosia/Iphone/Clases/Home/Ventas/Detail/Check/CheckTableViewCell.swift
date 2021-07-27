//
//  CheckTableViewCell.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 24/07/21.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDescripcion : UILabel!
    
    var objBE : CheckBE!{
        didSet{
            self.lblDescripcion.text = "(\(self.objBE.faccan_e ?? "")) \(self.objBE.tardes ?? "") (S/\(self.objBE.facnet1 ?? ""))"
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
