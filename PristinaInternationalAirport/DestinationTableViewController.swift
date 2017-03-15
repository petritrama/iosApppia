//
//  DestinationTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class DestinationTableViewController: UITableViewController {
    
    let destinationsMenuItems = [   Localization("menuSchedule"),
                                    Localization("menuDestinations"),
                                    Localization("menuCoordination"),
                                    Localization("menuAppliacionFlight"),
                                    Localization("menuPublication")]
    
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        return destinationsMenuItems.count
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
        
        cell!.textLabel?.text = destinationsMenuItems[indexPath.row]
        
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
        var destViewController : Destination_ViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Destination_ViewController") as! Destination_ViewController
        
        switch (indexPath.row)
        {
        case 0:
            destViewController.titleString = Localization("title_schedule")
            destViewController.contentString = Localization("text_schedule")
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 1:
            var destViewController : DestinationsItemTableViewController
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("DestinationsItem_ViewController") as! DestinationsItemTableViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 2:
            destViewController.titleString = Localization("title_schedule_coordination")
            destViewController.contentString = Localization("text_schedule_coordination")
            destViewController.imgString = "schedule_coordination"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 3:
            destViewController.titleString = Localization("title_application_flights")
            destViewController.contentString = Localization("text_application_flights")
            destViewController.imgString = "application_flights"
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 4:
            var destViewController : PublicationsItemTableViewController
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PublicationsItemTableViewController") as! PublicationsItemTableViewController
            sideMenuController()?.setContentViewController(destViewController)
            break
        default:
            destViewController.titleString = Localization("title_schedule")
            destViewController.contentString = Localization("text_schedule")
            sideMenuController()?.setContentViewController(destViewController)
            break
        }
    }
    
    func receiveLanguageChangedNotification(notification:NSNotification)
    {
        configureViewFromLocalisation()
    }
    
    func configureViewFromLocalisation()
    {
        
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}
