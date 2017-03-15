//
//  News_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 1/30/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class newsClass
{
    var titulli_al:String?
    var pershkrimi_al:String?
    var data:String?
    var filename:String?
    var tituli_en:String?
    var pershkrimi_en:String?
    
    init(json:NSDictionary)
    {
        self.titulli_al = json["1"] as? String
        self.pershkrimi_al = json["2"] as? String
        self.data = json["3"] as? String
        self.filename = json["Filename"] as? String
        self.tituli_en = json["5"] as? String
        self.pershkrimi_en = json["6"] as? String
    }
}

class News_TableViewCell: UITableViewCell
{
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAnotherLaptop: UILabel!
}

class News_ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ENSideMenuDelegate
{
    
    var newsInfo = [newsClass]()
    
    @IBOutlet weak var tblNews: UITableView!
    
    @IBAction func btnBackClick(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MyVC")
        self.presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @IBAction func btnMenuClick(sender: AnyObject) {
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tblNews.dataSource = self
        self.sideMenuController()?.sideMenu?.delegate
        
        self.title = Localization("lblNews")
        
        let requestURL: NSURL = NSURL(string: "http://46.99.150.6/enter/json/jsonn.php")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as? NSHTTPURLResponse
            let statusCode = httpResponse?.statusCode
            
            if (statusCode == 200)
            {
                do{
                    
                    let newsJSON = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSArray
                    
                    for news in newsJSON
                    {
                        let newsInfo = newsClass(json: news as! NSDictionary)
                        self.newsInfo.append(newsInfo)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tblNews.reloadData()
                })
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("newsInfoCell") as! News_TableViewCell
        
        let urlString = "http://46.99.150.6/images/"+self.newsInfo[indexPath.row].filename!
        if let url = NSURL(string:urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                cell.imgNews.image = UIImage(data: data)
            }
        }
        
        cell.lblTitle.text = self.newsInfo[indexPath.row].tituli_en
        cell.lblContent.text = self.newsInfo[indexPath.row].pershkrimi_en
        cell.lblDate.text =  self.newsInfo[indexPath.row].data
        
        cell.layer.cornerRadius = 2
        cell.layer.borderColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0).CGColor
        cell.layer.borderWidth = 5
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let fullNewsController = storyboard?.instantiateViewControllerWithIdentifier("FullNewsViewController") as! FullNewViewController
        
        fullNewsController.imgString = newsInfo[indexPath.row].filename!
        fullNewsController.titleString = newsInfo[indexPath.row].tituli_en!
        fullNewsController.contentString = newsInfo[indexPath.row].pershkrimi_en!
        
        self.navigationController?.pushViewController(fullNewsController, animated: true)
        
    }
    
}
