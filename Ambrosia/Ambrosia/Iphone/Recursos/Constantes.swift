//
//  Constantes.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import Foundation
import UIKit

public class ServicesURL: NSObject {
    
    public static let urlBase   = "http://ambrosiabeta.is-by.us:8085/licencia_beta/"
    public static let adminURL  = Configuration.sharedInstance.configurationUrlServices
    
    struct Licencia {
        static let licencia  = urlBase + "licencia_validar.php"
        static let caja      = adminURL + "/cajas_consultar.php"
        static let almacen   = adminURL + "/almacenes_consultar.php"
        static let sedes     = adminURL + "/sedes_consultar.php"
    }
    
    struct User {
        static let getUser   = adminURL + "/usuarios_consultar.php"
    }
    
    struct Balance {
        static let balance   = adminURL + "/cajas_control_cab_consultar.php?"
        static let resumen   = adminURL + "/cajas_control_resumen_consultar.php?"
    }
    
    struct Ventas {
        static let ventas     = adminURL + "/cajas_control_detalle_ventas.php?"
        static let check      = adminURL + "/factura_detalle.php?"
        static let documento  = adminURL + "/factura_cabecera.php?"
        static let pago       = adminURL + "/factura_fpago.php?"
    }
    
    struct Comprobante {
        static let pago       = adminURL + "/cobranza_cambio_fpago.php"
        static let cambio     = adminURL + "/cobranza_cambio_comprobante.php"
        static let anular     = adminURL + "/comprobante_anular.php?"
    }
}

struct Segue {
    
    static let LoginViewController          = "LoginViewController"
    static let AdminViewController          = "AdminViewController"
    static let PickerGeneralViewController  = "PickerGeneralViewController"
    static let PickerDateViewController     = "PickerDateViewController"
    static let MenuViewController           = "MenuViewController"
    static let HomeViewController           = "HomeViewController"
    static let SecurityViewController       = "SecurityViewController"
    static let SplashViewController         = "SplashViewController"
    static let VentasViewController         = "VentasViewController"
    static let DetailVentasViewController   = "DetailVentasViewController"
    static let FormaDePagoAlertViewController   = "FormaDePagoAlertViewController"
    static let AnularaViewController        = "AnularaViewController"
}

struct CellIdentifier {
    
    static let LoginCollectionViewCell  = "LoginCollectionViewCell"
    static let HomeTableViewCell        = "HomeTableViewCell"
    static let VentasTableViewCell      = "VentasTableViewCell"
    static let CheckTableViewCell       = "CheckTableViewCell"
    static let PagoTableViewCell        = "PagoTableViewCell"
}

enum LDDateType{
    case date
    case start_time_minute
    case end_time_minute
}

enum UIMenuVentas : Int{
    case imprimir       = 0
    case correo         = 1
    case cambio_pago    = 2
    case cambio_compro  = 3
    case anular         = 4
}

enum FormatoPago : String {
    case efectivo   = "EF"
    case tarjeta    = "TA"
    case banco      = "DB"
    case cortesia   = "CG"
}

extension UIViewController{
    
    func classNameAsString() -> String{
        return String(describing: type(of: self))
    }
    
    @IBAction func btnExit(_ sender : Any?){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapKeyboard(_ sender : Any?){
        self.view.endEditing(true)
    }
 
    @IBAction func btnDismiss(_ sender : Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
    public func animateBackGround(color : UIColor){
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = color
            self.view.layoutIfNeeded()
        }
    }
}
