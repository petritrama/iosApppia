//
//  PublicationsItemTableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/23/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class publicationsClass
{
    var title:String?
    var link:String?
    
    init(json:NSDictionary)
    {
        self.title = json["title"] as? String
        self.link = json["link"] as? String
    }
}

class Publication_TableViewCell: UITableViewCell
{
    @IBOutlet weak var lblTitle: UILabel!
}

class PublicationsItemTableViewController: UITableViewController {

    @IBOutlet var tblPubl: UITableView!
    
    var publInfo = [publicationsClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Localization("lblDestination")
        
        tblPubl.separatorStyle = .None
        tblPubl.rowHeight = 75
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/jsonp.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    let publicationInfoJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for publ in publicationInfoJSON
                    {
                        let publications = publicationsClass(json: publ as! NSDictionary)
                        self.publInfo.append(publications)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblPubl.reloadData()
                })
            }
        }
        
        task.resume()
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return publInfo.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("publCell") as! Publication_TableViewCell
        
        cell.lblTitle.text = self.publInfo[indexPath.row].title
        
        cell.layer.cornerRadius = 2.5
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let url = publInfo[indexPath.row].link!
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
}
