//
//  ExploreTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/21/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class ExploreTableViewController: UITableViewController
{
    let exploreMenuItems = [Localization("menuCompanyProfile"),
                            Localization("menuHistory"),
                            Localization("menuLimak"),
                            Localization("manuADLMS"),
                            Localization("menuOrganisatioin"),
                            Localization("menuVission"),
                            Localization("menuCEO"),
                            Localization("menuPolicy"),
                            Localization("menuSocial"),
                            Localization("menuCareer"),
                            Localization("menuMap"),
                            Localization("menuRent"),
                            Localization("menuBank"),
                            Localization("menuRestaurnat"),
                            Localization("menuFreeShop"),
                            Localization("menuAirlines"),
                            Localization("menuAd"),
                            Localization("menuTaxi")]
    
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
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
        
        return exploreMenuItems.count
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
        
        cell!.textLabel?.text = exploreMenuItems[indexPath.row]
        
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
        var destViewController : Explore_ViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Explore_ViewController") as! Explore_ViewController
        
        switch (indexPath.row)
        {
        case 0:
            destViewController.titleString = Localization("title_companyprofile")
            destViewController.contentString = Localization("text_companyprofile")
            destViewController.imgString = "companyprofile"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 1:
            destViewController.titleString = Localization("title_history")
            destViewController.contentString = Localization("text_history")
            destViewController.imgString = "history"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 2:
            destViewController.titleString = Localization("title_limak")
            destViewController.contentString = Localization("text_limak")
            destViewController.imgString = "limak"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 3:
            destViewController.titleString = Localization("title_adlms")
            destViewController.contentString = Localization("text_adlms")
            destViewController.imgString = "adlms"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 4:
            destViewController.titleString = Localization("title_organization")
            destViewController.contentString = Localization("")
            destViewController.imgString = "organization"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 5:
            destViewController.titleString = Localization("title_missionvision")
            destViewController.contentString = Localization("text_missionvision")
            destViewController.imgString = "missionvision"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 6:
            destViewController.titleString = Localization("title_ceo")
            destViewController.contentString = Localization("text_ceo")
            destViewController.imgString = "ceo"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 7:
            destViewController.titleString = Localization("title_management")
            destViewController.contentString = Localization("text_management")
            destViewController.imgString = "management"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 8:
            destViewController.titleString = Localization("title_responsibility")
            destViewController.contentString = Localization("text_responsibility")
            destViewController.imgString = "responsibility"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 9:
            destViewController.titleString = Localization("title_career")
            destViewController.contentString = Localization("text_career")
            destViewController.imgString = "career"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 10:
            destViewController.titleString = ""
            destViewController.contentString = ""
            destViewController.imgString = ""
            destViewController.map1Bool = false
            destViewController.map2Bool = false
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 11:
            var destViewController : RentViewController
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("RentViewController") as! RentViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 12:
            destViewController.titleString = Localization("title_bank")
            destViewController.contentString = Localization("text_bank")
            destViewController.imgString = "bank"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 13:
            destViewController.titleString = Localization("title_restaurants")
            destViewController.contentString = Localization("text_restaurants")
            destViewController.imgString = "restaurants"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 14:
            destViewController.titleString = Localization("title_shop")
            destViewController.contentString = Localization("text_shop")
            destViewController.imgString = "shop"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 15:
            var destViewController : AirlinesTableViewController
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AirlinesTableViewController") as! AirlinesTableViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 16:
            destViewController.titleString = Localization("title_ad")
            destViewController.contentString = Localization("text_ad")
            destViewController.imgString = "ad"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 17:
            destViewController.titleString = Localization("title_taxi")
            destViewController.contentString = Localization("text_taxi")
            destViewController.imgString = "taxi"
            sideMenuController()?.setContentViewController(destViewController)
            break
        default:
            destViewController.titleString = Localization("title_companyprofile")
            destViewController.contentString = Localization("text_companyprofile")
            destViewController.imgString = "companyprofile"
            sideMenuController()?.setContentViewController(destViewController)
            break
        }
        //sideMenuController()?.setContentViewController(destViewController)
    }
}
