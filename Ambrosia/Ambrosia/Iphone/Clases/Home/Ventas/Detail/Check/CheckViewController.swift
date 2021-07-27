//
//  CheckViewController.swift
//  Ambrosia
//
//  Created by Alexander Ynoñan H. on 22/07/21.
//

import UIKit

class CheckViewController: UIViewController {
    
    @IBOutlet weak private var tblCheck : UITableView!

    var controllerDetail : DetailVentasViewController?
    
    public var arrayVentas = [CheckBE](){
        didSet{
            self.tblCheck.reloadSections(IndexSet(arrayLiteral: 0), with: .top)
        }
    }
    
    lazy var refreshControll : UIRefreshControl! = {
       
        var objRefreshControll = UIRefreshControl()
        
        objRefreshControll.tintColor = .darkGray
        objRefreshControll.addTarget(self, action: #selector(self.getCheck), for: .valueChanged)
        
        return objRefreshControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLoad()
        // Do any additional setup after loading the view.
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

//MARK: -METHODS
extension CheckViewController {
    
    public func getLoad(){
        self.controllerDetail?.controllerCheck = self
        self.tblCheck.backgroundView = self.refreshControll
        self.getCheck()
    }
    
    @objc public func getCheck(){
        self.refreshControll.beginRefreshing()
        VentasBL.getFacturaCheck(secfac: self.controllerDetail?.objVentas?.secnum ?? "") { array in
            self.refreshControll.endRefreshing()
            self.arrayVentas = array
        } errorServices: { errorMessage in
            self.refreshControll.endRefreshing()
        }
    }
}

//MARK: -TableView
extension CheckViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayVentas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = CellIdentifier.CheckTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CheckTableViewCell
        
        cell.objBE = self.arrayVentas[indexPath.row]
        
        return cell
    }
}
