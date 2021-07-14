//
//  CDUsuario.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit
import CoreData

class CDUsuario: NSObject {

    class func save(user : UserBE){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let contexto = appDelegate.persistentContainer.viewContext
   
        let obj = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: contexto) as! Usuario
        
        obj.usunam = user.usunam
        obj.usucod = user.usucod
        obj.usudes = user.usudes
        obj.patpas = user.patpas
        
        appDelegate.saveContext()
    }
        
    class private func deleteObject(conObject : [Usuario]){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
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
    
    class func listarTodos() -> [Usuario]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let contexto = appDelegate.persistentContainer.viewContext
        
        let fetch : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        let usunam = NSSortDescriptor(key: "usunam", ascending: true)
        let usucod  = NSSortDescriptor(key: "usucod", ascending: true)
        let usudes  = NSSortDescriptor(key: "usudes", ascending: true)
        let patpas  = NSSortDescriptor(key: "patpas", ascending: true)
        
        fetch.sortDescriptors = [usunam,usucod,usudes,patpas]
        
        do {
           let result = try contexto.fetch(fetch)
            return result
        } catch  {
            return []
        }
    }
    
    class func deleteUser() {
        let data = CDUsuario.listarTodos()
        self.deleteObject(conObject: data)
    }
    
}
