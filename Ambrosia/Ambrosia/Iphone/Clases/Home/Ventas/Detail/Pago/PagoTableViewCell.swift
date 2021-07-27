//
//  PagoTableViewCell.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 24/07/21.
//

import UIKit

class PagoTableViewCell: UITableViewCell {

    @IBOutlet weak private var lblPago : UILabel!
    @IBOutlet weak private var lblPrice : UILabel!
    @IBOutlet weak private var lblDescripcion : UILabel!
    @IBOutlet weak private var constraintPAgo : NSLayoutConstraint!
    @IBOutlet weak private var btnFPago : UIButton!
    @IBOutlet weak public var viewStyle : UIView!
    
    var controller : UIViewController?
    
    var objBE : PagoBE!{
        didSet{
            self.lblPrice.text = self.objBE.moncob
            self.showFPago(show: self.objBE.state)
            self.validateFormPay(id:self.objBE.fpacod ?? "")
        }
    }
    
    private func validateFormPay(id:String){
        var text = ""
        switch FormatoPago(rawValue: id) {
        case .efectivo:
            self.lblPago.text = self.objBE.fpades
            text = "Recibido: S/\(self.objBE.monrec ?? "") / Vuelto: S/\(self.objBE.monvue ?? "")"
        case .tarjeta:
            self.lblPago.text = "\(self.objBE.fpades ?? ""): \(self.objBE.tiptar ?? "")"
            text = "Lote: \(self.objBE.lottar ?? "") / Referencia: \(self.objBE.reftar ?? "")"
        case .banco:
            self.lblPago.text = "\(self.objBE.fpades ?? ""): \(self.objBE.tipban ?? "")"
            text = "Operac: \(self.objBE.opeban ?? "") / Observ: \(self.objBE.fpaobs ?? "")"
        case .cortesia:
            self.lblPago.text = self.objBE.fpades
            text = "Tipo: \(self.objBE.tipcor ?? "") / Observ: \(self.objBE.fpaobs ?? "")"
        default:
            text = ""
        }
        self.lblDescripcion.text = text
    }
    
    private func showFPago(show : Bool){
        self.btnFPago.alpha = show ? 1 : 0
        self.constraintPAgo.constant = show ? 15 : 0
    }
    
    @IBAction func btnPago(_ sender : UIButton){
        self.controller?.performSegue(withIdentifier: Segue.FormaDePagoAlertViewController, sender: self.objBE)
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
