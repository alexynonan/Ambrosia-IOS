//
//  AnularaViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 26/07/21.
//

import UIKit

protocol AnularaViewControllerDelegate {
    func sendAnular(controller : AnularaViewController)
}

class AnularaViewController: UIViewController {

    @IBOutlet weak private var txtRegstro   : UITextField!
    @IBOutlet weak private var lblBoleta    : UILabel!
    @IBOutlet weak private var btnConfirmar : UIButton!
    @IBOutlet weak private var activityConfirmar : UIActivityIndicatorView!
    
    var objVentas : VentasBE?
    var delegate : AnularaViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAnular()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateBackGround(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
    }
    
    @IBAction private func btnSendAnular(_ sender : UIButton){
        self.sendAnular()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: -METHODS
extension AnularaViewController {
    
    private func loadAnular(){
        self.view.backgroundColor = .clear
        self.animateSenBoton(show: false)
        self.lblBoleta.text = "\(self.objVentas?.comdes ?? "") \(self.objVentas?.sernum ?? "")-\(self.objVentas?.facnum ?? "") (OP.\(self.objVentas?.secnum ?? "")) (S/\(self.objVentas?.facnet ?? ""))"
    }
    
    private func sendAnular(){
        self.animateSend(show: true)
        VentasBL.sendAnular(obj: self.objVentas!) { message in
            self.animateSend(show: false)
            self.showAlert(withTitle: Alert.titleError, withMessage: message, withAcceptButton: Alert.agreedButton) {                
                self.dismiss(animated: true) {
                    self.delegate?.sendAnular(controller: self)
                }
            }
        } errorServices: { errorMessage in
            self.animateSend(show: false)
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: errorMessage, withAcceptButton: Alert.agreedButton, withCompletion: nil)
        }
    }
    
    private func animateSend(show : Bool){
        show ? self.activityConfirmar.startAnimating() : self.activityConfirmar.stopAnimating()
        self.view.isUserInteractionEnabled = !show
    }
    
    private func animateSenBoton(show : Bool){
        self.btnConfirmar.backgroundColor = show ? #colorLiteral(red: 0.8729166389, green: 0.4028925896, blue: 0, alpha: 1) : #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.261538474)
        self.btnConfirmar.isUserInteractionEnabled = show
    }
    
}

//MARK: -Delegate Texfield
extension AnularaViewController: CAYTextFieldDelegate {

    func textFieldUserDidEndEditing(_ textField: CAYTextField) {
        
        if textField == self.txtRegstro{
            self.objVentas?.descripcion = textField.text ?? ""
            if let text = ValidationsBL.validateText(textField.text, message: Alert.Form.error_motivo){
                self.animateSenBoton(show: false)
                textField.showErrorMessageWithText(text)
            }else{
                self.animateSenBoton(show: true)
                textField.hideErrorMessage()
            }
        }
    }
}
