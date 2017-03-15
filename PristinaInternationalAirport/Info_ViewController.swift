//
//  Info_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class Info_ViewController: UIViewController {
    
    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    var imgString = "info"
    var titleString = Localization("title_info")
    var contentString = Localization("text_info")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization("lblInfo")
        
        imgInfo.image = UIImage(named: imgString)
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
}
