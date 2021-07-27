//
//  Alert.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import Foundation

struct Alert {
    
    static let agreedButton             = "Entiendo"
    static let cancelButton             = "Cancelar"
    static let acceptButton             = "Aceptar"
    static let titleUpsError            = "UPS!"
    static let titleError               = "Ambrosia"
    static let messageSession           = "Session expirada"
    static let messageSuccess           = "Excelente!"
    static let messageAdjunt            = "ADJUNTAR"
    static let messageFile              = "Files"
    static let messageUpdate            = "Actualizar"
    static let acceptGalary             = "Galeria"
    static let acceptCamera             = "Camara"
    static let notFoundCamera           = "Device has no camera"
    static let selectAnOption           = "Seleccione una opción:"
    static let problemServices          = "Problemas con el Servicio"
    static let configureServices        = "Configure Servidor"
    
    struct Licencia {
        
        static let messageOK            = "LICENCIA CONFORME REINICIE APP"
        static let messageError         = "LICENCIA NO VÁLIDA"
        static let messageLicencia      = "Ingrese la licencia"
    }
    
    struct Home {
        static let messageErrorModul    = "En mantenimiento"
    }
    
    struct Form {
        static let error_email           = "Correo no valido"
        static let error_documento       = "Documento no valido"
        static let error_reniec          = "RENIEC"
        static let error_sunat           = "SUNAT"
        static let error_link            = "Ingrese el vínculo de la reunión"
        static let error_motivo          = "Ingrese un Motivo"
    }
    
    struct Pago {
        static let messageComprobanteAnulada = "El Comprobante ha sido Anulado"
        static let messageComprobante        = "Comprobante cambiado correctamente"
        static let messageComprobanteError   = "Error al cambiar comprobante"
        static let messageErrorAnularCompro  = "Error al anular comprobante"
    }
}
