//
//  CDLicencia.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit
import CoreData

class CDLicencia: NSObject {
    
    class func save(licencia : LicenciaBE) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let contexto = appDelegate.persistentContainer.viewContext
   
        let obj = NSEntityDescription.insertNewObject(forEntityName: "Licencia", into: contexto) as! Licencia
        
        obj.servidor = licencia.servidor
        obj.licencia = licencia.licencia
        obj.almcod = licencia.almcod
        obj.cajcod = licencia.cajcod
        obj.impres1 = licencia.impres1
        obj.impres2 = licencia.impres2
        obj.qrcuenta = licencia.qrcuenta
        obj.resumen = licencia.resumen
        obj.sednum = licencia.sednum
        
        appDelegate.saveContext()
    }
        
    class private func deleteObject(conObject : [Licencia]){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Licencia")
        
        fetchRequest.includesPropertyValues = false
        
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        do{
            for item in conObject{
                context.delete(item)
            }
            try context.save()
        }catch{
            print("Error")
        }
    }
    
    class func listarTodos() -> [Licencia]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contexto = appDelegate.persistentContainer.viewContext
        
        let fetch : NSFetchRequest<Licencia> = Licencia.fetchRequest()
        
        let servidor = NSSortDescriptor(key: "servidor", ascending: true)
        let licencia  = NSSortDescriptor(key: "licencia", ascending: true)
        let almcod = NSSortDescriptor(key: "almcod", ascending: true)
        let cajcod  = NSSortDescriptor(key: "cajcod", ascending: true)
        let impres1 = NSSortDescriptor(key: "impres1", ascending: true)
        let impres2  = NSSortDescriptor(key: "impres2", ascending: true)
        let qrcuenta = NSSortDescriptor(key: "qrcuenta", ascending: true)
        let resumen  = NSSortDescriptor(key: "resumen", ascending: true)
        let sednum  = NSSortDescriptor(key: "sednum", ascending: true)
        
        fetch.sortDescriptors = [servidor,licencia,almcod,cajcod,impres1,impres2,qrcuenta,resumen,sednum]
        
        do {
           let result = try contexto.fetch(fetch)
            return result
        } catch  {
            return []
        }
    }
    
    class func deleteLicencia() {
        let data = CDLicencia.listarTodos()
        self.deleteObject(conObject: data)
    }
    
}
