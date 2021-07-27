//
//  DetailVentasViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

protocol DetailVentasViewControllerDelegate {
    func showDetail(control : DetailVentasViewController)
    func showAlert(control : DetailVentasViewController)
}

class DetailVentasViewController: UIViewController {

    @IBOutlet private var arrayViewAnimate     : [UIView]!
    @IBOutlet private var arraybtnStyleSelect  : [UIButton]!
    @IBOutlet private var arrayViewStyleSelect : [UIView]!
    @IBOutlet private var arrayViewStyleComprobante : [UIView]!
    @IBOutlet weak private var lblPago : UILabel!
    @IBOutlet weak private var lblTitlePago     : UILabel!
    @IBOutlet weak private var btnChanguePago   : UIButton!
    @IBOutlet weak public var activityComprobante : UIActivityIndicatorView!
    
    var objVentas           : VentasBE?
    var controllerDocumento : DocumentosViewController?
    var controllerCheck     : CheckViewController?
    var controllerPago      : PagoViewController?
    var delegate            : DetailVentasViewControllerDelegate?
    var controllerFormaPago : FormaDePagoAlertViewController?
    
    var indexSendPago       = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadValidations()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        self.animateBackGround(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.showDetail(control: self)
        self.view.backgroundColor = .clear
    }
    
    @IBAction private func btnSelectDetail(_ sender : UIButton){
        self.animateSelect(sender: sender.tag) {
        }
    }
    
    @IBAction private func btnConfirmarComprobante(_ sender : UIButton){
        if self.indexSendPago == 0{
            self.controllerPago?.sendPago()
        }else{
            self.controllerDocumento?.sendComrobante()
        }
    }
    
    @IBAction private func btnSelectTabBar(_ sender : UIButton){
        switch UIMenuVentas(rawValue: sender.tag) {
        case .cambio_pago:
            self.validationPago(state: false)            
            self.controllerPago?.stateEdit = true
            self.controllerPago?.tblPago.reloadData()
            self.animateChangueComplete(show: true, sender: 2)
        case .cambio_compro:
            self.animateChangueComplete(show: true, sender: 1)
            self.controllerDocumento?.validationForm(show: true)
            return
        case .anular:
            self.performSegue(withIdentifier: Segue.AnularaViewController, sender: nil)
        default:
            self.dismiss(animated: true) {
                self.delegate?.showAlert(control: self)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? CheckViewController{
            controller.controllerDetail = self
        }else if let controller = segue.destination as? DocumentosViewController{
            controller.controllerDetail = self
        }else if let controller = segue.destination as? PagoViewController{
            controller.controllerDetail = self
        }else if let controller = segue.destination as? FormaDePagoAlertViewController{
            controller.controllerDetail = self
        }else if let controller = segue.destination as? AnularaViewController{
            controller.objVentas = self.objVentas
            controller.delegate = self
        }
    }
    

}

// MARK: -AnularaViewControllerDelegate
extension DetailVentasViewController: AnularaViewControllerDelegate {
    
    func sendAnular(controller: AnularaViewController) {
        self.btnDismiss(nil)
    }
}

// MARK: - METHODS
extension DetailVentasViewController {
    
    private func loadValidations(){
        self.controllerCheck?.controllerDetail = self
        self.controllerDocumento?.controllerDetail = self
        self.controllerFormaPago?.controllerDetail = self
        self.controllerPago?.controllerDetail = self
        self.lblPago.text = "Total S/\(self.objVentas?.facnet ?? "")"
        self.view.backgroundColor = .clear
        self.animateChangueComplete(show: false,sender: 1)
        self.validationPago(state: true)
    }
    
    func validationPago(state : Bool){
        self.indexSendPago = state ? 1 : 0
        let color = state ? #colorLiteral(red: 0.7649177909, green: 0.6073020101, blue: 0, alpha: 1) : #colorLiteral(red: 0.08691959828, green: 0.4297593832, blue: 0.5387525558, alpha: 1)
        self.arrayViewStyleComprobante[0].backgroundColor = color
        let text = state ? "CONFIRMAR COMPROBANTE" : "CONFIRMAR FORMA DE PAGO"
        self.btnChanguePago.setTitle(text, for: .normal)
        let title = state ? "REGISTRE NUEVO COMPROBANTE" : "REGISTRE NUEVA FORMA DE PAGO"
        self.lblTitlePago.text = title
    }
    
    func animateChangueComplete(show : Bool,sender : Int){
        self.animateSelect(sender: sender) {
            self.arrayViewStyleComprobante.forEach({$0.alpha = show ? 1 : 0})
        }
    }
    
    public func animateSend(_ show : Bool){
        show ? self.activityComprobante.startAnimating() : self.activityComprobante.stopAnimating()
        self.view.isUserInteractionEnabled = !show
    }
    
    func animateSelect(sender : Int,success : Closures.Success? = nil){
        
        self.arrayViewAnimate.forEach({$0.alpha = 0})
        self.arrayViewStyleSelect.forEach({$0.alpha = 0})
    
        UIView.transition(with: self.arrayViewAnimate[sender], duration: 0.25, options: .transitionFlipFromLeft) {
            self.arrayViewAnimate[sender].alpha = 1
            self.arrayViewStyleSelect[sender].alpha = 1
        } completion: { state in
            success?()
        }
    }
}
