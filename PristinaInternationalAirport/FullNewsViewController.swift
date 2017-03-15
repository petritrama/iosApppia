//
//  FullNewViewController.swift
//  PristinaInternationalAirport
//
//  Created by mac on 2/2/17.
//  Copyright © 2017 PIA. All rights reserved.
//

import UIKit


class FullNewViewController: UIViewController {

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UITextView!
    
    var imgString = ""
    var titleString = ""
    var contentString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let urlString = "http://46.99.150.6/images/"+imgString
        if let url = NSURL(string:urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                imgNews.image = UIImage(data: data)
            }
        }
        
        lblTitle.text = titleString
        lblContent.text = contentString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
