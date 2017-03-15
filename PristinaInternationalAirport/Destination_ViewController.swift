//
//  Destination_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class Destination_ViewController: UIViewController {

    @IBOutlet weak var imgDestination: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtContent: UITextView!
    
    var titleString = Localization("title_schedule")
    var contentString = Localization("text_schedule")
    var imgString = "schedule"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgDestination.image = UIImage(named: imgString)
        lblTitle.text = titleString
        txtContent.text = contentString
        
        self.title = Localization("lblDestination")
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
