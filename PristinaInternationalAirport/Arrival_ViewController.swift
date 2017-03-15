//
//  Arrival_TableViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 1/18/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class arrivalClass
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
        self.destination = json["FROM"] as? String
        self.schedule = json["SCHEDULE"] as? String
        self.status = json["STATUS"] as? String
    }
}

class Arrival_TableViewCell: UITableViewCell
{
    @IBOutlet weak var lblAirline: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblFlightNr: UILabel!
}


class Arrival_ViewController: UIViewController, UITableViewDataSource
{
    var arrivalFlightInfo = [arrivalClass]()
    
    @IBOutlet weak var tblArrivalInfo: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblArrivalInfo.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        self.title = Localization("tab_arrival")
        self.tblArrivalInfo.separatorStyle = .None
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/a.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    
                    let arrivalInfoJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for flight in arrivalInfoJSON
                    {
                        let arrivalFlight = arrivalClass(json: flight as! NSDictionary)
                        self.arrivalFlightInfo.append(arrivalFlight)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblArrivalInfo.reloadData()
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
        return arrivalFlightInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("arrivalInfoCell") as! Arrival_TableViewCell
        
        cell.lblAirline.text = self.arrivalFlightInfo[indexPath.row].airline
        cell.lblFlightNr.text = self.arrivalFlightInfo[indexPath.row].flightnr
        cell.lblDestination.text = self.arrivalFlightInfo[indexPath.row].destination
        cell.lblSchedule.text = self.arrivalFlightInfo[indexPath.row].schedule
        cell.lblStatus.text = self.arrivalFlightInfo[indexPath.row].status
        
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
        self.title = Localization("tab_arrival")
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}

