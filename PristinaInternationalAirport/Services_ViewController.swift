//
//  Services_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class Services_ViewController: UIViewController {

    @IBOutlet weak var imgServices: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    var imgString = "services"
    var titleString = Localization("title_services")
    var contentString = Localization("text_services")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localization("lblServices")
        
        imgServices.image = UIImage(named: imgString)
        lblTitle.text = titleString
        txtContent.text = contentString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClick(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }

    @IBAction func btnMenuClick(sender: AnyObject) {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
