//
//  FlightInfo_ViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 1/18/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit

class FlightInfo_ViewController: UITabBarController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveLanguageChangedNotification:", name: kNotificationLanguageChanged, object: nil)
        
        configureViewFromLocalisation()
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
        self.title = Localization("flightInfoScene")
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
}
