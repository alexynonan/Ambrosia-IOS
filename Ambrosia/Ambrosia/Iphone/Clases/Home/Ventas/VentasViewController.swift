//
//  VentasViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class VentasViewController: UIViewController {

    @IBOutlet private weak var tblVentas    : UITableView!
    @IBOutlet private weak var lblName      : UILabel!
    
    var controller : UIViewController?
    
    var objResumen : BalanceResumenBE?
    
    var arrayVentas = [VentasBE](){
        didSet{
            self.tblVentas.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
        }
    }
    
    lazy private var refreshControll : UIRefreshControl! = {
       
        var objRefreshControl = UIRefreshControl()
        objRefreshControl.tintColor = .darkGray
        objRefreshControl.addTarget(self, action: #selector(self.getVentas), for: .valueChanged)
        return objRefreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblName.text = self.objResumen?.totdes?.uppercased()
        self.view.backgroundColor = .clear
        self.tblVentas.backgroundView = self.refreshControll
        self.getVentas()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        self.animateBackGround(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
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
extension VentasViewController {
    
    @objc private func getVentas(){
        self.refreshControll.beginRefreshing()
        VentasBL.getVentas { array in
            self.refreshControll.endRefreshing()
            self.arrayVentas = array
        } errorServices: { error in
            self.refreshControll.endRefreshing()
            self.showAlert(withTitle: Alert.titleUpsError, withMessage: error, withAcceptButton: Alert.agreedButton) {
                self.btnDismiss(nil)
            }
        }
    }
    
}


//MARK: -TableView
extension VentasViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayVentas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = CellIdentifier.VentasTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! VentasTableViewCell
        
        cell.objBE = self.arrayVentas[indexPath.row]
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? #colorLiteral(red: 0.948946774, green: 0.9490604997, blue: 0.9489082694, alpha: 1) : .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.arrayVentas[indexPath.row]
        self.dismiss(animated: true) {
            self.controller?.performSegue(withIdentifier: Segue.DetailVentasViewController, sender: obj)
        }
    }
}
