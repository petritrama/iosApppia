//
//  RentViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class rentClass
{
    var tel1:String?
    var tel2:String?
    var tel3:String?
    var tel4:String?
    var email:String?
    var web:String?
    var logo:String?
    var schedula:String?
    
    init(rentArray:NSDictionary)
    {
        self.tel1 = rentArray[1] as? String
        self.tel2 = rentArray[2] as? String
        self.tel3 = rentArray[3] as? String
        self.tel4 = rentArray[4] as? String
        self.email = rentArray[5] as? String
        self.web = rentArray[6] as? String
        self.logo = rentArray[7] as? String
        self.schedula = rentArray[8] as? String
    }
}

class rentCellClass : UITableViewCell
{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblTel1: UILabel!
    @IBOutlet weak var lblTel2: UILabel!
    @IBOutlet weak var lblTel3: UILabel!
    @IBOutlet weak var lblTel4: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblWeb: UILabel!
}

class RentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ENSideMenuDelegate
{
    @IBOutlet weak var tblRent: UITableView!
    
    var rentArray = [rentClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblRent.delegate = self
        tblRent.dataSource = self
        
        tblRent.rowHeight = 150
        
        let rentDir1 = [1:"+377 44 240 383",2:"+377 45 445 533",3:"",4:"",5:"info@rentacar-prishtina.com",6:"www.rentacar-prishtina.com",7:"prishtina",8:""]
        let rent1 = rentClass(rentArray: rentDir1)
        
        let rentDir2 = [1:"+377-45-612-613",2:"+386-49-518-518",3:"+377-45-665-663",4:"+377-45-666-779",5:"rentacar.roberti@gmail.com",6:"www.rentacar-roberti.com",7:"roberti",8:"24h"]
        let rent2 = rentClass(rentArray: rentDir2)
        
        let rentDir3 = [1:"+377-45-967-967",2:"+386-49-840-840",3:"+377-44-388-888",4:"+386-49-388-888",5:"rent.autoking@gmail.com",6:"www.king-rent.com",7:"king",8:"24h"]
        let rent3 = rentClass(rentArray: rentDir3)
        
        let rentDir4 = [1:"+381 38 594 338",2:"+377 44 488 666",3:"+377 44 399 395",4:"+377 44 566 668",5:"info@rentacarautolux.com",6:"www.rentacarautolux.com",7:"autolux",8:""]
        let rent4 = rentClass(rentArray: rentDir4)
        
        let rentDir5 = [1:"+381 38 594 101",2:"+377 44 116 746",3:"+377 44 122 040",4:"",5:"info@europcar-ks.com",6:"www.europcar-ks.com",7:"europcar",8:""]
        let rent5 = rentClass(rentArray: rentDir5)
        
        let rentDir6 = [1:"+381 38 594 555",2:"+377 44 594 555",3:"+386 49 594 555",4:"",5:"info@hertzkosovo.com",6:"www.hertzkosovo.com",7:"hertz",8:""]
        let rent6 = rentClass(rentArray: rentDir6)
        
        let rentDir7 = [1:"+377 45 505 101",2:"",3:"",4:"",5:"info@interrent-ks.com",6:"www.interrent-ks.com",7:"interrent",8:"08:00-24:00 Mo-Su"]
        let rent7 = rentClass(rentArray: rentDir7)
        
        let rentDir8 = [1:"+381 38 594 595",2:"+377 44 665 668",3:"+386 49 665 668",4:"",5:"info@kosovatrade-ks.com",6:"www.kosovatrade-ks.com",7:"kosova",8:""]
        let rent8 = rentClass(rentArray: rentDir8)
        
        let rentDir9 = [1:"+37744700047",2:"+37744111417",3:"+38649100080 ",4:"",5:"nshrentacarmara@outlook.com",6:"www.rentmara.com",7:"mara",8:"24h"]
        let rent9 = rentClass(rentArray: rentDir9)
        
        let rentDir10 = [1:"+377 45 535 536",2:"+381 38 534 517",3:"",4:"",5:"info@sixtkosovo.com",6:"www.sixt.com",7:"sixt",8:"(8am - 12pm Mo - Su)"]
        let rent10 = rentClass(rentArray: rentDir10)
        
        let rentDir11 = [1:"+377 44 286 286",2:"+377 44 283 283",3:"+377 44 350 970",4:"+381 38 603 224",5:"info@rentacarshotani.com",6:"www.rentacarshotani.com",7:"shotani",8:"(24/7)"]
        let rent11 = rentClass(rentArray: rentDir11)
        
        let rentDir12 = [1:"+377 44 721 721",2:"+381290325021",3:"",4:"",5:"info@sherretirent.com",6:"www.sherretirent.com",7:"autosherreti",8:""]
        let rent12 = rentClass(rentArray: rentDir12)
        
        rentArray.append(rent1)
        rentArray.append(rent2)
        rentArray.append(rent3)
        rentArray.append(rent4)
        rentArray.append(rent5)
        rentArray.append(rent6)
        rentArray.append(rent7)
        rentArray.append(rent8)
        rentArray.append(rent9)
        rentArray.append(rent10)
        rentArray.append(rent11)
        rentArray.append(rent12)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBackClick(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("rentCell", forIndexPath: indexPath) as! rentCellClass
        
        cell.lblTel1.text = rentArray[indexPath.row].tel1
        cell.lblTel2.text = rentArray[indexPath.row].tel2
        cell.lblTel3.text = rentArray[indexPath.row].tel3
        cell.lblTel4.text = rentArray[indexPath.row].tel4
        cell.lblWeb.text = rentArray[indexPath.row].web
        cell.lblEmail.text = rentArray[indexPath.row].email
        cell.lblSchedule.text = rentArray[indexPath.row].schedula
        cell.imgLogo.image = UIImage(named: rentArray[indexPath.row].logo!)
        
        cell.layer.cornerRadius = 2.5
        cell.layer.borderWidth = 0.2
        
        return cell
    }
}
