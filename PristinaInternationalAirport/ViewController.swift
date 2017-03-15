//
//  ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 10/15/15.
//  Copyright © 2015 PIA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var lblFlightInfo: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblExploreAirport: UILabel!
    @IBOutlet weak var lblServices: UILabel!
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var lblNews: UILabel!
    
    @IBOutlet var langPicker: UIPickerView!
    let langPickerData = ["ENG","SHQ","SRB"]

    let arrayLanguages = Localisator.sharedInstance.getArrayAvailableLanguages()
    var langg = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        langPicker.delegate = self
        langPicker.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        Localisator.sharedInstance.saveInUserDefaults = true
        
        langg = Localisator.sharedInstance.getLanguage()
        langPicker.selectRow(langg, inComponent: 0, animated: false)
        
        configureViewFromLocalisation()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func receiveLanguageChangedNotification(notification:NSNotification)
    {
        configureViewFromLocalisation()
    }
    
    func configureViewFromLocalisation()
    {
        lblFlightInfo.text = Localization("lblFlight")
        lblDestination.text = Localization("lblDestination")
        lblExploreAirport.text = Localization("lblExplore")
        lblServices.text = Localization("lblServices")
        lblInformation.text = Localization("lblInfo")
        lblNews.text = Localization("lblNews")
    }
    
    @IBAction func btnExplore(sender: AnyObject)
    {
    }
    
    @IBAction func btnDestinations(sender: AnyObject)
    {
    }
    
    @IBAction func btnServices(sender: AnyObject)
    {
    }
    
    @IBAction func btnNews(sender: AnyObject)
    {
    }
    
    @IBAction func btnInfo(sender: AnyObject)
    {
    }
    
    @IBOutlet var insta: UIButton!
    @IBAction func btnInstaClick(sender: AnyObject)
    {
        let instagramHooks = "instagram://airportpristina"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.sharedApplication().canOpenURL(instagramUrl!)
        {
            UIApplication.sharedApplication().openURL(instagramUrl!)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.sharedApplication().openURL(NSURL(string: "http://instagram.com/_u/airportpristina")!)
        }
    }
    
    @IBOutlet weak var btnFBClick: UIButton!
    @IBAction func btnFBClick(sender: AnyObject)
    {
        let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/airportpristina")!
        let fbURLID: NSURL = NSURL(string: "fb://page/1440677106221985")!
        
        if(UIApplication.sharedApplication().canOpenURL(fbURLID))
        {
            UIApplication.sharedApplication().openURL(fbURLID)
        } else
        {
            UIApplication.sharedApplication().openURL(fbURLWeb)
        }
    }
    
    @IBOutlet weak var btnTwiter: UIButton!
    @IBAction func btnTwiterClick(sender: AnyObject)
    {
        let twiterURLWeb: NSURL = NSURL(string: "https://www.twitter.com/airportpristina")!
        let twiterURLID: NSURL = NSURL(string: "twitter://user?user_id=2744886516")!
        
        if(UIApplication.sharedApplication().canOpenURL(twiterURLID))
        {
            UIApplication.sharedApplication().openURL(twiterURLID)
        } else
        {
            UIApplication.sharedApplication().openURL(twiterURLWeb)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return langPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return langPickerData[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        SetLanguage(arrayLanguages[langPicker.selectedRowInComponent(0) + 1])
    }

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        return NSAttributedString(string:langPickerData[row],attributes: [NSFontAttributeName:UIFont(name:"Georgia", size:10.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}

