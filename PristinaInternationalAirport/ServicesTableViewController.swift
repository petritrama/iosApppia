//
//  ServicesTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class ServicesTableViewController: UITableViewController {
    
    let servicesMenuItems = [   Localization("menuServices"),
                                Localization("menuPHS"),
                                Localization("menuLostFound"),
                                Localization("menuCIP"),
                                Localization("menuCommercial"),
                                Localization("menuRAMP"),
                                Localization("menuCargo"),
                                Localization("menuSecurity"),
                                Localization("menuMedical"),
                                Localization("menuICT") ]
    
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localization("lblServices")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        configureViewFromLocalisation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return servicesMenuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.blackColor()
            cell!.textLabel?.numberOfLines = 2
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = servicesMenuItems[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            sideMenuController()?.sideMenu?.toggleMenu()
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : Services_ViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Services_ViewController") as! Services_ViewController
        
        switch (indexPath.row)
        {
        case 0:
            destViewController.titleString = Localization("title_services")
            destViewController.contentString = Localization("text_services")
            destViewController.imgString = "services"
            break
        case 1:
            destViewController.titleString = Localization("title_phs")
            destViewController.contentString = Localization("text_phs")
            destViewController.imgString = "phs"
            break
        case 2:
            destViewController.titleString = Localization("title_lost")
            destViewController.contentString = Localization("text_lost")
            destViewController.imgString = "lost_found"
            break
        case 3:
            destViewController.titleString = Localization("title_cip")
            destViewController.contentString = Localization("text_cip")
            destViewController.imgString = "cip"
            break
        case 4:
            destViewController.titleString = Localization("title_commercial")
            destViewController.contentString = Localization("text_commercial")
            destViewController.imgString = "commercial"
            break
        case 5:
            destViewController.titleString = Localization("title_ramp")
            destViewController.contentString = Localization("text_ramp")
            destViewController.imgString = "ramp"
            break
        case 6:
            destViewController.titleString = Localization("title_cargo")
            destViewController.contentString = Localization("text_cargo")
            destViewController.imgString = "cargo"
            break
        case 7:
            destViewController.titleString = Localization("title_security")
            destViewController.contentString = Localization("text_security")
            destViewController.imgString = "security"
            break
        case 8:
            destViewController.titleString = Localization("title_medical")
            destViewController.contentString = Localization("text_medical")
            destViewController.imgString = "medical"
            break
        case 9:
            destViewController.titleString = Localization("title_ict")
            destViewController.contentString = Localization("text_ict")
            destViewController.imgString = "ict"
            break
        default:
            destViewController.titleString = Localization("title_services")
            destViewController.contentString = Localization("text_services")
            destViewController.imgString = ""
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    func receiveLanguageChangedNotification(notification:NSNotification)
    {
        configureViewFromLocalisation()
    }
    
    func configureViewFromLocalisation()
    {
        self.title = Localization("tab_arrival")
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}
