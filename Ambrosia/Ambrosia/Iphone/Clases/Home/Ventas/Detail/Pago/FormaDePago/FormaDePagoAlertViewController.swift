//
//  FormaDePagoAlertViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 24/07/21.
//

import UIKit

class FormaDePagoAlertViewController: UIViewController {

    @IBOutlet weak private var constraintAlert      : NSLayoutConstraint!
    @IBOutlet weak private var constraintAlertForm  : NSLayoutConstraint!
    @IBOutlet private var arrayViewFormaPago        : [UIView]!
    
    @IBOutlet weak private var lblTitle             : UILabel!
    @IBOutlet weak private var lblTipoPago          : UILabel!
    @IBOutlet private var arrayViewStyleForm        : [UIView]!
    @IBOutlet private var arrayFormTitle            : [UILabel]!
    @IBOutlet weak private var constraintTxtForm    : NSLayoutConstraint!
    @IBOutlet private var viewtxtForm               : UIView!
    @IBOutlet private var arraytxtForm              : [CAYTextField]!
    @IBOutlet private var btnStyleSend               : UIButton!
    
    var controllerDetail : DetailVentasViewController?
    var idPago           = FormatoPago.efectivo
    var arrayFormaPago   = [Any]()
    var colorState       = UIColor.gray
    var validationForm : [CAYTextField] = []{
        didSet{
            self.animate(color: self.colorState, show: self.validationForm.count == 0 ? true : false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPago()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
        NotificationCenter.default.removeObserver(self)
    }

    
    @IBAction func btnSelectPago(_ sender : UIButton){
        self.changueTitle(tag: sender.tag)
        self.animateShowAlertForm()
    }

    @IBAction func btnExitAlert(_ sender : UIButton){
        self.animateExitAlert()
    }
    
    @IBAction private func btnTipoAlert(_ sender : UIButton){
        self.performSegue(withIdentifier: Segue.PickerGeneralViewController, sender: self.arrayFormaPago)
    }
    
    @IBAction private func addPago(_ sender : UIButton){
        self.sendChanguePay()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controllers = segue.destination as? PickerGeneralViewController{
            controllers.arrayGeneral = sender as! [Any]
            controllers.delegate = self
        }
    }

}

extension FormaDePagoAlertViewController: PickerGeneralViewControllerDelegate{
    
    func showSelect(controller: PickerGeneralViewController, sender: Any?, tag: Int) {
        
        if let tarjeta : TarjetaBE = sender as? TarjetaBE{
            self.lblTipoPago.text = tarjeta.name
            
        }else if let banco : BancoBE = sender as? BancoBE{
            self.lblTipoPago.text = banco.name
            
        }else if let cortesia : CortesiaBE = sender as? CortesiaBE{
            self.lblTipoPago.text = cortesia.name
        }
    }
}

//MARK: -METHODS
extension FormaDePagoAlertViewController {
    
    private func loadPago(){
        self.controllerDetail?.controllerFormaPago = self
        self.arrayViewFormaPago[0].alpha = 1
        self.arrayViewFormaPago[1].alpha = 0
        self.constraintAlert.constant = 0
        self.constraintAlertForm.constant = -10000
        self.validationForm = self.arraytxtForm
    }
    
    private func sendChanguePay(){
        
        switch self.idPago {
        
        case .tarjeta:
            
            let objTarjeta = PagoBE()
                    
            objTarjeta.fpacod = self.idPago.rawValue
            objTarjeta.tiptar = self.lblTipoPago.text
            objTarjeta.fpades = "TARJETA"
            objTarjeta.moncob = self.arraytxtForm[0].text // monto cobrar
            objTarjeta.lottar = self.arraytxtForm[1].text // tarjeta lotte
            objTarjeta.reftar = self.arraytxtForm[2].text // Tarjeta referencia
            
            self.controllerDetail?.controllerPago?.arrayPago.append(objTarjeta)
            self.controllerDetail?.controllerPago?.arrayAddPago.append(objTarjeta)
        case .banco:
        
            let objBanco = PagoBE()
                    
            objBanco.fpacod = self.idPago.rawValue
            objBanco.tipban = self.lblTipoPago.text
            objBanco.fpades = "BANCOS"
            objBanco.moncob = self.arraytxtForm[0].text // monto cobrar
            objBanco.opeban = self.arraytxtForm[1].text // operacion bancaria
            objBanco.fpaobs = self.arraytxtForm[2].text // observaciones banco
            
            self.controllerDetail?.controllerPago?.arrayPago.append(objBanco)
            self.controllerDetail?.controllerPago?.arrayAddPago.append(objBanco)
        case .cortesia:
            
            let objCortesia = PagoBE()
                    
            objCortesia.fpacod = self.idPago.rawValue
            objCortesia.tipcor = self.lblTipoPago.text
            objCortesia.fpades = "CORTESIA"
            objCortesia.moncob = self.arraytxtForm[0].text // monto cobrar
            objCortesia.fpaobs = self.arraytxtForm[1].text // observaciones banco
            
            self.controllerDetail?.controllerPago?.arrayPago.append(objCortesia)
            self.controllerDetail?.controllerPago?.arrayAddPago.append(objCortesia)
        default:
            return
        }
        self.btnDismiss(nil)
    }
    
    private func changueTitle(tag : Int){
        var color = UIColor.black
        self.validationForm = self.arraytxtForm
        switch tag {
        case 0:
            self.arrayFormaPago = VentasBL.getTarjeta()
            self.lblTipoPago.text = VentasBL.getTarjeta().first?.name
            self.idPago = .tarjeta
            self.lblTitle.text = "PAGO CON TARJETA"
            self.arraytxtForm[0].text = ""
            self.arraytxtForm[1].text = ""
            self.arraytxtForm[2].text = ""
            self.arrayFormTitle[0].text = "Tipo de Tarjeta"
            self.arrayFormTitle[2].text = "Lote"
            self.arrayFormTitle[3].text = "Referencia"
            color = #colorLiteral(red: 0.8724756837, green: 0.3792518973, blue: 0, alpha: 1)
            self.constraintTxtForm.constant = 15
            self.viewtxtForm.alpha = 1
        case 1:
            self.arrayFormaPago = VentasBL.getBancos()
            self.lblTipoPago.text = VentasBL.getBancos().first?.name
            self.idPago = .banco
            self.lblTitle.text = "PAGO BANCARIO"
            self.arraytxtForm[0].text = ""
            self.arraytxtForm[1].text = ""
            self.arraytxtForm[2].text = ""
            self.arrayFormTitle[0].text = "Tipo de Transacción"
            self.arrayFormTitle[2].text = "Operación"
            self.arrayFormTitle[3].text = "Observaciones"
            self.constraintTxtForm.constant = 15
            self.viewtxtForm.alpha = 1
            color = #colorLiteral(red: 0.5980955958, green: 0.4787831903, blue: 0, alpha: 1)
        case 4:
            self.arrayFormaPago = VentasBL.getCortesia()
            self.lblTipoPago.text = VentasBL.getCortesia().first?.name
            self.idPago = .cortesia
            self.arraytxtForm[0].text = ""
            self.arraytxtForm[1].text = ""
            self.lblTitle.text = "DESCUENTO / CORTESÍA"
            self.arrayFormTitle[0].text = "Tipo de Cortesia"
            self.arrayFormTitle[2].text = "Observaciones"
            self.arrayFormTitle[3].text = ""
            self.validationForm.removeAll(where: {$0 == self.arraytxtForm[2]})
            self.constraintTxtForm.constant = -50
            self.viewtxtForm.alpha = 0
            color = #colorLiteral(red: 0.6788796782, green: 0.2107815146, blue: 0, alpha: 1)
        default:
            self.lblTitle.text = ""
        }
        self.colorState = color
        self.animate(color: color, show: false)
        self.arrayViewStyleForm.forEach({$0.backgroundColor = color})
    }
    
    private func animate(color : UIColor,show : Bool){
        self.btnStyleSend.backgroundColor = show ? color : #colorLiteral(red: 0.7411188483, green: 0.7412089705, blue: 0.7410882115, alpha: 1)
        self.btnStyleSend.isUserInteractionEnabled = show
    }
    
    private func animateShowAlertForm(){
        UIView.animate(withDuration: 0.8){
            self.constraintAlert.constant = -1000
            self.arrayViewFormaPago[0].alpha = 0
            self.arrayViewFormaPago[0].transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
            self.view.layoutIfNeeded()
        } completion: { bool in
            self.arrayViewFormaPago[0].transform = .identity
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseInOut) {
                self.constraintAlertForm.constant = 0
                self.arrayViewFormaPago[1].alpha = 1
                self.arrayViewFormaPago[1].transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.view.layoutIfNeeded()
            } completion: { (state) in
                
                self.arrayViewFormaPago[1].transform = .identity
            }
        }
    }
    
    private func animateExitAlert(){
        self.btnTapKeyboard(nil)
        self.constraintAlertForm.constant = 1000
        UIView.animate(withDuration: 0.9, delay: 0.1, options: .curveEaseInOut) {
            self.arrayViewFormaPago[1].transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.view.layoutIfNeeded()
        } completion: { (state) in
            self.arrayViewFormaPago[1].alpha = 0
            UIView.animate(withDuration: 0.25) {
                self.constraintAlert.constant = 0
                self.arrayViewFormaPago[0].transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
                self.arrayViewFormaPago[0].transform = .identity
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.arrayViewFormaPago[0].alpha = 1
                
            }
        }
    }
}

//MARK: -CAYTexfieldDelegate
extension FormaDePagoAlertViewController : CAYTextFieldDelegate{

    func textFieldUserDidEndEditing(_ textField: CAYTextField) {
        
        if textField == self.arraytxtForm[0]{
            if let _ = ValidationsBL.validateText(textField.text, message: ""){
                self.validationForm.append(textField)
            }else{
                self.validationForm.removeAll(where: {$0 == self.arraytxtForm[0]})
            }
        }else if textField == self.arraytxtForm[1]{
            if let _ = ValidationsBL.validateText(textField.text, message: ""){
                self.validationForm.append(textField)
            }else{
                self.validationForm.removeAll(where: {$0 == self.arraytxtForm[1]})
            }
        }else if textField == self.arraytxtForm[2]{
            if let _ = ValidationsBL.validateText(textField.text, message: ""){
                self.validationForm.append(textField)
            }else{
                self.validationForm.removeAll(where: {$0 == self.arraytxtForm[2]})
            }
        }
    }
}

//MARK: -KEYBOARD
extension FormaDePagoAlertViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK: - Notification Keyboard
    
    @objc func keyBoardWillShow(_ notification: Notification){
        
        let keySize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let viewAmcho = self.view.frame.width / 2
        
        let final = keySize!.height - viewAmcho
        
        UIView.animate(withDuration: 0.35) {
            self.constraintAlertForm.constant = -final
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyBoardWillHide(_ notification: Notification){
        UIView.animate(withDuration: 0.35, animations: {
            self.constraintAlertForm?.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}
