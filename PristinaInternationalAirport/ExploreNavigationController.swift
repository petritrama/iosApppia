//
//  ExploreNavigationController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/21/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class ExploreNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: ExploreTableViewController(), menuPosition:ENSideMenuPosition.right)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 225.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        //sideMenu?.allowPanGesture = false
        view.bringSubviewToFront(navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
