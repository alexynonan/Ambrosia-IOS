//
//  HomeViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 12/07/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var tblBalance   : UITableView!
    @IBOutlet private weak var lblName      : UILabel!
    @IBOutlet private weak var lblCentral   : UILabel!
    @IBOutlet private weak var lblsec       : UILabel!
    @IBOutlet private weak var lblInicio    : UILabel!
//    @IBOutlet private weak var lblCierre    : UILabel!
    @IBOutlet private weak var lblCajaChica : UILabel!
    
    var objUser = UserBE()
    var arrayResumen = [BalanceResumenBE](){
        didSet{
            self.tblBalance.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
        }
    }
    
    lazy private var refreshControll : UIRefreshControl! = {
       
        var objRefreshControl = UIRefreshControl()
        objRefreshControl.tintColor = .darkGray
        objRefreshControl.addTarget(self, action: #selector(self.loadBalance), for: .valueChanged)
        return objRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblBalance.backgroundView = self.refreshControll
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadBalance()
    }
    
    @IBAction private func btnMenu(_ sender : UIButton){
        self.performSegue(withIdentifier: Segue.MenuViewController, sender: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MenuViewController{
            controller.delegate = self
            controller.objUse = self.objUser
        }else if let controller = segue.destination as? AdminViewController{
            controller.delegate = self
        }
    }
    

}

//MARK: -Methods

extension HomeViewController {
  

    @objc private func loadBalance(){
        
        self.refreshControll.beginRefreshing()
        
        self.lblName.text = self.objUser.usunam
        
        BalanceBL.getBalance { array in
            
            self.lblCentral.text = array.first?.cajdes
            self.lblsec.text = "\(array.first?.secnum ?? "") \(array.first?.cajest ?? "")"
            self.lblInicio.text = "\(array.first?.fecape_s ?? "") \(array.first?.usuape ?? "") \n  \(array.first?.feccie_s ?? "") \(array.first?.usucie ?? "")"
            self.lblCajaChica.text = array.first?.totchi
            
            BalanceBL.getResumen(path: array.first?.secnum ?? "") { array in
                self.refreshControll.endRefreshing()
                self.arrayResumen = array
            } errorServices: { error in
                self.refreshControll.endRefreshing()
            }
        } errorServices: { error in
            self.refreshControll.endRefreshing()
        }
    }
    
    private func generalSession(){
        CDUsuario.deleteUser()
        CDLicencia.deleteLicencia()
    }
    
}

//MARK: -TableView
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayResumen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = CellIdentifier.HomeTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeTableViewCell
        
        cell.objBE = self.arrayResumen[indexPath.row]
        
        return cell
    }
}

//MARK: -Menu
extension HomeViewController : MenuViewControllerDelegate{
    
    func exitSession(controller: MenuViewController, state: Bool) {
        self.generalSession()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showAdmin(controller: MenuViewController, state: Bool){
        self.performSegue(withIdentifier: Segue.AdminViewController, sender: nil)
    }
    
    func showBalance(controller: MenuViewController, state: Bool) {
        
    }
}

//MARK: -Admin
extension HomeViewController : AdminViewControllerDelegate{
    
    func reiniciarApp(controller: AdminViewController, state: Bool) {
        
        if state{
            self.generalSession()
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.loadBalance()
        }
    }
}
