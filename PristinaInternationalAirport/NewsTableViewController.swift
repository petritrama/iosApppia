//
//  NewsTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/18/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController
{
    let newsMenuItems = [Localization("menuNews"), Localization("menuMediaEnquiry")]
    var selectedMenuItem : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
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
        
        return newsMenuItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.blackColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = newsMenuItems[indexPath.row]
        
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
        var destViewController : UIViewController
        let contentViewController : ContentNewsViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("News_ViewController")
            sideMenuController()?.setContentViewController(destViewController)
            break
        case 1:
            contentViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ContentNewsViewController") as! ContentNewsViewController
            contentViewController.titleString = Localization("title_media")
            contentViewController.contentString = Localization("text_media")
            sideMenuController()?.setContentViewController(contentViewController)
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("News_ViewController")
            sideMenuController()?.setContentViewController(destViewController)
            break
        }
        //sideMenuController()?.setContentViewController(destViewController)
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
