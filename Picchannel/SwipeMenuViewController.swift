//
//  SwipeMenuViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2015/11/22.
//  Copyright © 2015年 ktp. All rights reserved.
//

import UIKit

class SwipeMenuViewController: UIViewController {
    
    @IBAction func searchMediaByTagName(sender: AnyObject) {
        let tagNameButton:UIButton = sender as! UIButton
        let tagName : NSString = tagNameButton.currentTitle!
        print(tagName)
        // let tagNameViewController : UIViewController = SelfFeedViewController()
        // tagNameViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        // self.presentedViewController(tagNameViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red:0.21, green:0.33, blue:0.31, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}