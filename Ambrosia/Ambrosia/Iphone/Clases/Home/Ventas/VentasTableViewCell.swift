//
//  VentasTableViewCell.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class VentasTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle     : CAYLabel!
    @IBOutlet weak var lblSubTitle  : CAYLabel!
    @IBOutlet weak var lblPrice     : CAYLabel!
    @IBOutlet weak var lblName      : CAYLabel!
    
    var objBE : VentasBE!{
        didSet{
            self.changueState(show: self.objBE.facest == "A" ? true : false)
        }
    }
    
    private func changueState(show : Bool){
        
        self.lblTitle.text = "\(self.objBE.comdes ?? "") \(self.objBE.sernum ?? "")-\(self.objBE.facnum ?? "") (OP.\(self.objBE.secnum ?? ""))"
        self.lblSubTitle.text = "\(self.objBE.facfec_s ?? "") (\(self.objBE.usunam ?? ""))"
        self.lblPrice.text = self.objBE.facnet
        self.lblName.text = self.objBE.clides
        
        self.lblName.middleLine = show
        self.lblTitle.middleLine = show
        self.lblSubTitle.middleLine = show
        self.lblPrice.middleLine = show
        
        self.lblName.textColor = show ? #colorLiteral(red: 0.7148658037, green: 0.3139614165, blue: 0.1431030631, alpha: 1) : .black
        self.lblTitle.textColor = show ? #colorLiteral(red: 0.7148658037, green: 0.3139614165, blue: 0.1431030631, alpha: 1) : .black
        self.lblSubTitle.textColor = show ? #colorLiteral(red: 0.7148658037, green: 0.3139614165, blue: 0.1431030631, alpha: 1) : .black
        self.lblPrice.textColor = show ? #colorLiteral(red: 0.7148658037, green: 0.3139614165, blue: 0.1431030631, alpha: 1) : .black
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
