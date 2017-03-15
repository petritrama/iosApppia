//
//  Departure_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 1/18/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class departureClass
{
    var airline:String?
    var flightnr:String?
    var destination:String?
    var schedule:String?
    var status:String?
    
    init(json:NSDictionary)
    {
        self.airline = json["AIRLINE"] as? String
        self.flightnr = json["FLIGHT NUMBER"] as? String
        self.destination = json["TO"] as? String
        self.schedule = json["SCHEDULE"] as? String
        self.status = json["STATUS"] as? String
    }
}

class Departure_TableViewCell: UITableViewCell
{
    @IBOutlet weak var lblAirline: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblFlightNr: UILabel!
}


class Departure_ViewController: UIViewController, UITableViewDataSource
{
    var departureFlightInfo = [departureClass]()
    
    @IBOutlet weak var tblDepartureInfo: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        
        tblDepartureInfo.dataSource = self
        
        self.title = Localization("tab_departure")
        self.tblDepartureInfo.separatorStyle = .None
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/d.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    
                    let departureInfoJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for flight in departureInfoJSON
                    {
                        let departureFlight = departureClass(json: flight as! NSDictionary)
                        self.departureFlightInfo.append(departureFlight)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblDepartureInfo.reloadData()
                })
            }
        }
        
        task.resume()
        
        configureViewFromLocalisation()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departureFlightInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("departureInfoCell") as! Departure_TableViewCell
        
        cell.lblAirline.text = self.departureFlightInfo[indexPath.row].airline
        cell.lblFlightNr.text = self.departureFlightInfo[indexPath.row].flightnr
        cell.lblDestination.text = self.departureFlightInfo[indexPath.row].destination
        cell.lblSchedule.text = self.departureFlightInfo[indexPath.row].schedule
        cell.lblStatus.text = self.departureFlightInfo[indexPath.row].status
        
        cell.layer.cornerRadius = 2.5
        cell.layer.borderWidth = 0.2
        
        return cell
    }
    
    func receiveLanguageChangedNotification(notification:NSNotification)
    {
        configureViewFromLocalisation()
    }
    
    func configureViewFromLocalisation()
    {
        self.title = Localization("tab_departure")
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}
