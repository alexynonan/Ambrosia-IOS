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
    public static let adminURL  = ""
    
    struct Licencia {
        static let licencia  = urlBase + "licencia_validar.php"
        static let caja      = Configuration.sharedInstance.configurationUrlServices + "/cajas_consultar.php"
        static let almacen   = Configuration.sharedInstance.configurationUrlServices + "/almacenes_consultar.php"
        static let sedes     = Configuration.sharedInstance.configurationUrlServices + "/sedes_consultar.php"
    }
    
    struct User {
        static let getUser   = Configuration.sharedInstance.configurationUrlServices + "/usuarios_consultar.php"
    }
    
    struct Balance {
        static let balance   = Configuration.sharedInstance.configurationUrlServices + "/cajas_control_cab_consultar.php?"
        static let resumen   = Configuration.sharedInstance.configurationUrlServices + "/cajas_control_resumen_consultar.php?"
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
}

struct CellIdentifier {
    
    static let LoginCollectionViewCell  = "LoginCollectionViewCell"
    static let HomeTableViewCell        = "HomeTableViewCell"
}

enum LDDateType{
    case date
    case start_time_minute
    case end_time_minute
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
}
