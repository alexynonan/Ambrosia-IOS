//
//  SplashViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 13/07/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserBL.validateSession { obj in
            self.performSegue(withIdentifier: Segue.HomeViewController, sender: obj)
        } completionLogin: {
            self.performSegue(withIdentifier: Segue.LoginViewController, sender: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? HomeViewController{
            controller.objUser = sender as! UserBE
        }
    }

}
