//
//  SettingViewController.swift
//  tips
//
//  Created by sheng rong on 15/5/14.
//  Copyright (c) 2015年 Codepath. All rights reserved.
//

import UIKit

class SettingViewController : UIViewController{
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var percentageControl: UISegmentedControl!
    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var index = defaults.integerForKey("IndexOfDefaultPercentage");
        percentageControl.selectedSegmentIndex = index;
    }
    
    override func viewDidLayoutSubviews() {
        navbar.frame = CGRectMake(0, 0, 320, 64);
    }
    
    @IBAction func onDefaultPercentageChange(sender: AnyObject) {
        var segmentControl = sender as! UISegmentedControl
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(segmentControl.selectedSegmentIndex, forKey: "IndexOfDefaultPercentage");
        
    }
}
