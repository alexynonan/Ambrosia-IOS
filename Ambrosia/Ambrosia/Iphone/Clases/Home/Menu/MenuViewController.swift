//
//  MenuViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

protocol MenuViewControllerDelegate {
    func exitSession(controller : MenuViewController, state : Bool)
    func showAdmin(controller: MenuViewController, state: Bool)
    func showBalance(controller: MenuViewController, state: Bool)
}

class MenuViewController: UIViewController {

    @IBOutlet weak private var  lblNameOne : UILabel!
    @IBOutlet weak private var  lblNameTwo : UILabel!
    
    var delegate : MenuViewControllerDelegate?
    var objUse = UserBE()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblNameOne.text = self.objUse.usunam
        self.lblNameTwo.text = self.objUse.usudes
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnCloseSession(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.delegate?.exitSession(controller: self, state: true)
        }
    }

    @IBAction private func btnShowAdmin(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.delegate?.showAdmin(controller: self, state: true)            
        }
    }
    
    @IBAction private func btnBalance(_ sender : UIButton){
        self.dismiss(animated: true) {
            self.delegate?.showBalance(controller: self, state: true)
        }
    }
    
    @IBAction private func btnComandar(){
        self.showAlert(withTitle: Alert.titleUpsError, withMessage: Alert.Home.messageErrorModul, withAcceptButton: Alert.agreedButton, withCompletion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
