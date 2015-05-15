//
//  ViewController.swift
//  tips
//
//  Created by sheng rong on 15/5/13.
//  Copyright (c) 2015年 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var billField: UITextField!
    @IBOutlet var tipControl: UISegmentedControl!
    @IBOutlet var tipContainer: UIView!
    @IBOutlet var partyControl: UISwitch!
    @IBOutlet var billView: UIView!
    @IBOutlet var navbar: UINavigationBar!
    
    let BILL_VIEW_AFTER_POS_Y : CGFloat = 64;
    let BILL_VIEW_ORIGINAL_PSO_Y : CGFloat = 120;
    let TIP_VIEW_AFTER_POS_Y : CGFloat = 131;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
        tipContainer.frame.origin.y = self.view.frame.height;
        tipContainer.alpha = 0;
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var index = defaults.integerForKey("IndexOfDefaultPercentage");
        tipControl.selectedSegmentIndex = index;
        
        var amount = defaults.doubleForKey("BillAmount");
        if(amount==0){
            billField.text = "";
        }else{
            billField.text = String(format: "%.2f",defaults.doubleForKey("BillAmount"));
        }
        billView.frame.origin.y = self.BILL_VIEW_ORIGINAL_PSO_Y;
        billField.becomeFirstResponder();
        
        if(!billField.text.isEmpty){
            showTipContainer();
            onEditingChange(self);
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        navbar.frame = CGRectMake(0, 0, 320, 64);
    }

    @IBAction func onClickSetting(sender: AnyObject) {
        
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        if(billField.text==""){
            self.hideTipContainer();
        }else{
            self.showTipContainer();
        }
        var tipPercentages = [0.18,0.2,0.22];
        var tipPercentage = 0.18;
        if(partyControl.on){
            tipPercentage = 0.25;
        }else{
            tipPercentage = tipPercentages[tipControl.selectedSegmentIndex];
        }
        var billAmount = (billField.text as NSString).doubleValue;
        var tip = billAmount * tipPercentage;
        var total = billAmount + tip;
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble((billField.text as NSString).doubleValue, forKey: "BillAmount");
    }
    
    @IBAction func onPercentageChange(sender: AnyObject) {
        partyControl.setOn(false, animated: true);
        onEditingChange(sender);
    }
    
    @IBAction func onEditingEnd(sender: AnyObject) {
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
    
    @IBAction func onPartyChange(sender: AnyObject) {
        onEditingChange(sender);
    }
    
    func hideTipContainer(){
        UIView.animateWithDuration(0.5,
            delay: 0.1,
            options: .CurveEaseOut,
            animations: {
                self.tipContainer.frame.origin.y = self.view.frame.height;
                self.billView.frame.origin.y = self.BILL_VIEW_ORIGINAL_PSO_Y;
                self.tipContainer.alpha = 0;
                self.billView.alpha = 1;
            },
            completion:{finished in
                
            }
        );
    }
    
    func showTipContainer(){
        UIView.animateWithDuration(0.5,
            delay: 0.1,
            options: .CurveEaseOut,
            animations: {
                self.tipContainer.frame.origin.y = self.TIP_VIEW_AFTER_POS_Y;
                self.billView.frame.origin.y = self.BILL_VIEW_AFTER_POS_Y;
                self.tipContainer.alpha = 1.0;
                self.billView.alpha = 0.8;
            },
            completion:{finished in
                
            }
        );
    }
    
}

