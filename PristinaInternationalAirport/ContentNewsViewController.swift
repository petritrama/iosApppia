//
//  ContentViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/20/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class ContentNewsViewController: UIViewController {
    
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    var imgString = "media"
    var titleString = ""
    var contentString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgContent.image = UIImage(named: imgString)
        lblTitle.text = titleString
        txtContent.text = contentString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnBackClick(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func btnMenuClick(sender: AnyObject)
    {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
}
