//
//  DocumentosViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class DocumentosViewController: UIViewController {

    @IBOutlet private var arrayTxtForm : [UITextField]!
    @IBOutlet weak private var lblValidateDocuments : UILabel!
    @IBOutlet weak private var scrlDocument : UIScrollView!
    @IBOutlet weak private var lblComprobantePago : UILabel!
    
    
    var controllerDetail : DetailVentasViewController?
    
    public var objVentas = VentasBE()
    
    lazy var refreshControll : UIRefreshControl! = {
       
        var objRefreshControll = UIRefreshControl()
        
        objRefreshControll.tintColor = .darkGray
        objRefreshControll.addTarget(self, action: #selector(self.loadDocuments), for: .valueChanged)
        
        return objRefreshControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.validationLoad()
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
extension DocumentosViewController {
    
    private func validationLoad(){
        self.controllerDetail?.controllerDocumento = self
        self.validationForm(show: false)
        self.scrlDocument.addSubview(self.refreshControll)
        self.loadDocuments()
    }

    @objc private func loadDocuments(){
        self.refreshControll.beginRefreshing()
        let secfac = self.controllerDetail?.objVentas?.secnum
        
        VentasBL.getFacturaDocumento(secfac: secfac ?? "") { array in
            self.refreshControll.endRefreshing()
            self.objVentas = array.first!
            self.updateOutlet(obj: self.objVentas)
            self.refreshControll.removeFromSuperview()
        } errorServices: { errorMessage in
            self.refreshControll.endRefreshing()
            self.refreshControll.removeFromSuperview()
            self.controllerDetail?.showAlert(withTitle: Alert.titleUpsError, withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
        }
    }
    
    private func updateOutlet(obj : VentasBE){
        self.lblComprobantePago.text = "\(obj.comdes ?? "") \(obj.sernum ?? "") \(obj.facnum ?? "")".uppercased()
        self.arrayTxtForm[0].text = obj.tdonum
        self.arrayTxtForm[1].text = obj.clides
        self.arrayTxtForm[2].text = obj.facdir
        self.arrayTxtForm[3].text = obj.factel
        self.arrayTxtForm[4].text = obj.facobs
    }
    
    public func sendComrobante(){
        
        self.objVentas.tdonum = self.arrayTxtForm[0].text
        self.objVentas.clides = self.arrayTxtForm[1].text
        self.objVentas.facdir = self.arrayTxtForm[2].text
        self.objVentas.factel = self.arrayTxtForm[3].text
        self.objVentas.facobs = self.arrayTxtForm[4].text
        
        self.animateRegister(show: true)
        VentasBL.sendComprobante(obj: self.objVentas){ message in
            self.animateRegister(show: false)
            self.controllerDetail?.showAlert(withTitle: Alert.titleError, withMessage: message, withAcceptButton: Alert.agreedButton) {
                self.controllerDetail?.dismiss(animated: true, completion: nil)
            }
        } errorServices: { errorMessage in
            self.animateRegister(show: false)
            self.controllerDetail?.showAlert(withTitle: Alert.titleUpsError, withMessage: errorMessage, withAcceptButton: Alert.agreedButton) {
                self.controllerDetail?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func showVentasForm(){
        self.validationForm(show: false)
        self.controllerDetail?.animateChangueComplete(show: false, sender: 1)
    }
    
    public func validationForm(show : Bool){
        self.arrayTxtForm.forEach({$0.isEnabled = show})
    }
    
    private func animateRegister(show : Bool){
        show ? self.controllerDetail?.activityComprobante.startAnimating() : self.controllerDetail?.activityComprobante.stopAnimating()
        self.controllerDetail?.view.isUserInteractionEnabled = !show
    }
}

//MARK: UITEXFIELDDELEGATE
extension DocumentosViewController : CAYTextFieldDelegate {
    
    func textFieldUserDidEndEditing(_ textField: CAYTextField) {
        
        if textField == self.arrayTxtForm[0]{
            
            if let text = ValidationsBL.validateFormWithDocument(textField.text){
                self.lblValidateDocuments.text = text
                self.lblValidateDocuments.textColor = #colorLiteral(red: 0.1821387484, green: 0.8780270971, blue: 0, alpha: 1)
            }else{
                self.lblValidateDocuments.text = "---"
                self.lblValidateDocuments.textColor = .black
            }
        }
        
    }
    
}
