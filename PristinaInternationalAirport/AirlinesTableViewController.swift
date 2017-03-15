//
//  AirlinesTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/22/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class airlineClass
{
    var airline:String?
    var website:String?
    var logo:String?
    
    init(json:NSDictionary)
    {
        self.airline = json["airline"] as? String
        self.website = json["web"] as? String
        self.logo = json["Filename"] as? String
    }
}

class AirlineTableViewCell: UITableViewCell
{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblAirline: UILabel!
    @IBOutlet weak var lblWeb: UILabel!
}

class AirlinesTableViewController: UITableViewController,ENSideMenuDelegate {

    var airlineInfo = [airlineClass]()
    
    @IBOutlet var tblAirlines: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization("lblExplore")
        
        tblAirlines.rowHeight = 80
        tblAirlines.dataSource = self
        tblAirlines.separatorStyle = .None
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/jsona/php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    
                    let airlineInfoJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for airline in airlineInfoJSON
                    {
                        let airlines = airlineClass(json: airline as! NSDictionary)
                        self.airlineInfo.append(airlines)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblAirlines.reloadData()
                })
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return airlineInfo.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("airlineCell", forIndexPath: indexPath) as! AirlineTableViewCell
        
        let urlString = "http://46.99.150.6/images/"+self.airlineInfo[indexPath.row].logo!
        if let url = NSURL(string:urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                cell.imgLogo.image = UIImage(data: data)
            }
        }
        
        cell.lblAirline.text = self.airlineInfo[indexPath.row].airline
        cell.lblWeb.text = self.airlineInfo[indexPath.row].website
        
        cell.layer.cornerRadius = 2.5
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    @IBAction func btnBackClick(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
}
