//
//  DestinationsItemTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/23/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit


class destClass
{
    var airline:String?
    var logo:String?
    var destination:String?
    
    init(json:NSDictionary)
    {
        self.airline = json["airline"] as? String
        self.logo = json["Filename"] as? String
        self.destination = json["destinations"] as? String
    }
}

class Dest_TableViewCell: UITableViewCell
{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblAirline: UILabel!
    @IBOutlet weak var lblDestinations: UILabel!
}


class DestinationsItemTableViewController: UITableViewController
{
    @IBOutlet var tblDest: UITableView!
    
    var destInfo = [destClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization("lblDestination")
        
        tblDest.separatorStyle = .None
        tblDest.rowHeight = 100
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/jsond.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    
                    let destInfoJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for dest in destInfoJSON
                    {
                        let dest1 = destClass(json: dest as! NSDictionary)
                        self.destInfo.append(dest1)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblDest.reloadData()
                })
            }
        }
        
        task.resume()
    }
    
    @IBAction func btnBackClick(sender: AnyObject)
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return destInfo.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("destCell") as! Dest_TableViewCell
        
        let urlString = "http://46.99.150.6/images/"+self.destInfo[indexPath.row].logo!
        if let url = NSURL(string:urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                cell.imgLogo.image = UIImage(data: data)
            }
        }
        
        cell.lblAirline.text = self.destInfo[indexPath.row].airline
        cell.lblDestinations.text = self.destInfo[indexPath.row].destination
        
        cell.layer.cornerRadius = 2.5
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
}
