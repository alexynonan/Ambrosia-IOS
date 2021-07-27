//
//  Configuration.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class Configuration: NSObject {

    public static var sharedInstance = Configuration()
    
    public var configurationUrlServices = ""
    
    class func startNotification() -> Void{
                
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: { (granted, error) in
            
            DispatchQueue.main.async {
                
                print("User allows push notifications? \(granted ? "Yes!" : "No!")")
                print("\(error == nil ? " " : "-> \(error?.localizedDescription ?? "")")")
                if granted { /* El usuario permite recibir notificaciones. */
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
        })
    }
}
