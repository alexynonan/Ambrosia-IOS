//
//  AdminViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 10/07/21.
//

import UIKit

protocol AdminViewControllerDelegate {
    func reiniciarApp(controller: AdminViewController, state : Bool)
}

class AdminViewController: UIViewController {

    @IBOutlet weak private var txtLicencia      : UITextField!
    @IBOutlet weak private var lblStateLicencia : UILabel!
    @IBOutlet weak private var lblServidor      : UILabel!
    @IBOutlet weak private var lblCaja          : UILabel!
    @IBOutlet weak private var lblImpresora     : UILabel!
    @IBOutlet weak private var lblTwoImpresora  : UILabel!
    @IBOutlet weak private var lblResumenCocina : UILabel!
    @IBOutlet weak private var lblQRCuenta      : UILabel!
    @IBOutlet weak private var lblAlmacen       : UILabel!
    @IBOutlet weak private var lblLocal         : UILabel!
    @IBOutlet weak private var activityAdmin    : UIActivityIndicatorView!
    @IBOutlet private var      arraybtnSelect   : [UIButton]!
    
    var delegate : AdminViewControllerDelegate?
    
    private var arrayCaja       = [CajaBE]()
    private var arrayImpresora  = [ImpresoraBE]()
    private var arrayResumen    = [ResumenBE]()
    private var arrayQr         = [QrBE]()
    private var arrayAlmacen    = [AlmacenBE]()
    private var arraySedes      = [SedesBE]()
    private var index           = -1
    
    private var objLincencia = LicenciaBE()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.load()
        // Do any additional setup after loading the view.
    }
    

    @IBAction private func btnShowPicker(_ sender : UIButton){
        self.selectPicker(index: sender.tag)
    }
    
    @IBAction private func btnRequestAdmin(_ sender : Any?){
        self.validateLicencia()
    }
    
    @IBAction private func btnDismissAdmin(_ sender : Any?){
        
        if let _ = CDLicencia.listarTodos().first{
            CDLicencia.deleteLicencia()
            CDLicencia.save(licencia: self.objLincencia)
            self.dismiss(animated: true) {}
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? PickerGeneralViewController{
            controller.delegate = self
            controller.stateTipo = self.index
            controller.arrayGeneral = sender as! [Any]
        }
    }
}

//MARK: -METHODS

extension AdminViewController {
    
    private func load(){
        
        if let licencia = CDLicencia.listarTodos().first{
            
            self.txtLicencia.text = licencia.licencia
            self.lblServidor.text = licencia.servidor
            self.lblStateLicencia.text = "CONFORME"
                        
            self.objLincencia.almcod = licencia.almcod ?? ""
            self.objLincencia.cajcod = licencia.cajcod ?? ""
            self.objLincencia.impres1 = licencia.impres1 ?? ""
            self.objLincencia.impres2 = licencia.impres2 ?? ""
            self.objLincencia.qrcuenta = licencia.qrcuenta ?? ""
            self.objLincencia.resumen = licencia.resumen ?? ""
            self.objLincencia.sednum = licencia.sednum ?? ""
            self.objLincencia.licencia = self.txtLicencia.text ?? ""
            self.objLincencia.servidor = self.lblServidor.text ?? ""
            
            
            self.loadCaja()
            self.loadImpresora()
            self.loadResumen()
            self.loadQr()
            self.loadAlmacen()
            self.loadSedes()
        }else{
            self.arraybtnSelect.forEach({$0.isUserInteractionEnabled = false})
            self.txtLicencia.text = ""
            self.lblStateLicencia.text = "NO VÁLIDO"
        }
    }
    
    private func validateLicencia(){
        
        self.animateLoad(show: true)
        
        AdminBL.validateLicencia(text: self.txtLicencia.text ?? "") { message, servidor in

            self.animateLoad(show: false)

            self.lblServidor.text = servidor

            self.showAlert(withTitle: "", withMessage: message, withAcceptButton: Alert.agreedButton) {
                
                self.dismiss(animated: true) {
                    
                    self.delegate?.reiniciarApp(controller: self, state: true)
                }
            }
            
        } errorServices: { error in
            self.animateLoad(show: false)
            self.alertError(error: error)
        }

    }
    
    private func loadCaja(){
        AdminBL.getCaja { array in
            self.arrayCaja = array
            
            self.lblCaja.text = array.filter({$0.cojcod == self.objLincencia.cajcod }).first?.cajdes
            
        } errorServices: { error in
            self.alertError(error: error)
        }
    }
    
    private func loadImpresora(){
        AdminBL.getImpresoraOne { array in
            self.arrayImpresora = array
            
            self.lblImpresora.text = array.filter({$0.impresora_desc == self.objLincencia.impres1 }).first?.impresora_desc
            self.lblTwoImpresora.text = array.filter({$0.impresora_desc == self.objLincencia.impres2 }).first?.impresora_desc
        }
    }
    
    private func loadResumen(){
        AdminBL.getResumen { array in
            self.arrayResumen = array
            self.lblResumenCocina.text = array.first?.resumen_desc
            self.lblResumenCocina.text = array.filter({$0.resumen_desc == self.objLincencia.resumen}).first?.resumen_desc
        }
    }
    
    private func loadQr(){
        AdminBL.getQR { array in
            self.arrayQr = array
            self.lblQRCuenta.text = array.filter({$0.qr_desc == self.objLincencia.qrcuenta}).first?.qr_desc
        }
    }
    
    private func loadAlmacen(){
        AdminBL.getAlmacen { array in
            self.arrayAlmacen = array
            self.lblAlmacen.text = array.first?.almdes
            self.objLincencia.almcod = array.first?.almcod ?? ""
        } errorServices: { error in
            self.alertError(error: error)
        }
    }
    
    private func loadSedes(){
        AdminBL.getSedes { array in
            self.arraySedes = array
            self.lblLocal.text = array.first?.seddes
            self.objLincencia.sednum = array.first?.sednum ?? ""
        } errorServices: { error in
            self.alertError(error: error)
        }
    }
    
    private func selectPicker(index : Int){
        
        self.index = index
        
        var array = [Any]()
        
        switch index {
        case 0:
            array = self.arrayCaja
        case 1:
            array = self.arrayImpresora
        case 2:
            array = self.arrayImpresora
        case 3:
            array = self.arrayResumen
        case 4:
            array = self.arrayQr
        case 5:
            array = self.arrayAlmacen
        case 6:
            array = self.arraySedes
        default:
            return
        }
        
        self.performSegue(withIdentifier: Segue.PickerGeneralViewController, sender: array)
    }
    
    private func alertError(error : String){
        self.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton, withCompletion: nil)
    }
    
    
    private func animateLoad(show : Bool){
        show ? self.activityAdmin.startAnimating() : self.activityAdmin.stopAnimating()
        self.view.isUserInteractionEnabled = !show
    }
}

//MARK: -METHODS

extension AdminViewController : PickerGeneralViewControllerDelegate{
    
    func showSelect(controller: PickerGeneralViewController, sender: Any?, tag: Int) {
        
        if let caja = sender as? CajaBE{
            self.lblCaja.text = caja.cajdes
            self.objLincencia.cajcod = caja.cojcod ?? ""
            
        }else if let impresora = sender as? ImpresoraBE{
            if tag == 1{
                self.lblImpresora.text = impresora.impresora_desc
                self.objLincencia.impres1 = impresora.impresora_desc ?? ""
            }else{
                self.lblTwoImpresora.text = impresora.impresora_desc
                self.objLincencia.impres2 = impresora.impresora_desc ?? ""
            }
            
        }else if let resumen = sender as? ResumenBE {
            self.lblResumenCocina.text = resumen.resumen_desc
            self.objLincencia.resumen = resumen.resumen_desc ?? ""
            
        }else if let qr = sender as? QrBE{
            self.lblQRCuenta.text = qr.qr_desc
            self.objLincencia.qrcuenta = qr.qr_desc ?? ""
            
        }else if let almacen = sender as? AlmacenBE{
            self.lblAlmacen.text = almacen.almdes
            self.objLincencia.almcod = almacen.almcod ?? ""
            
        }else if let local = sender as? SedesBE {
            self.lblLocal.text = local.seddes
            self.objLincencia.sednum = local.sednum ?? ""
        }
    }
    
}
