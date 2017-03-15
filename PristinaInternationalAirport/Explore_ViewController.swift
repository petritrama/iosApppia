//
//  Explore_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/21/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class Explore_ViewController: UIViewController, ENSideMenuDelegate
{
    var imgString = "companyprofile"
    var titleString = Localization("title_companyprofile")
    var contentString = Localization("text_companyprofile")
    var map1Bool = true
    var map2Bool = true
    
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    @IBOutlet weak var imgMap1: UIImageView!
    @IBOutlet weak var imgMap2: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imgContent.image = UIImage(named: imgString)
        lblTitle.text = titleString
        txtContent.text = contentString
        imgMap1.hidden = map1Bool
        imgMap2.hidden = map2Bool
        
        self.title = Localization("lblExplore")
    }
    
    @IBAction func btnMenuClick(sender: AnyObject)
    {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    @IBAction func btnBackClick(sender: AnyObject)
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        
    }
    
}
