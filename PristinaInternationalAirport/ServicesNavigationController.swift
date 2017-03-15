//
//  ServicesNavigationController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class ServicesNavigationController:  ENSideMenuNavigationController, ENSideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localization("lblServices")
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: ServicesTableViewController(), menuPosition:ENSideMenuPosition.right)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 225.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        //sideMenu?.allowPanGesture = false
        view.bringSubviewToFront(navigationBar)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
