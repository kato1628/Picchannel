//
//  SwipeMenuViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2015/11/22.
//  Copyright © 2015年 ktp. All rights reserved.
//

import UIKit

class SwipeMenuViewController: UIViewController {
    
    var window :UIWindow?
    var tagNameButton :UIButton?
    var tagName :NSString?
    
    @IBAction func searchMediaByTagName(sender: AnyObject) {
        self.tagNameButton = sender as? UIButton
        self.tagName = tagNameButton!.currentTitle!
        performSegueWithIdentifier("toContainerViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("now view is \(self)")
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red:0.21, green:0.33, blue:0.31, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {   
        if (segue.identifier == "toContainerViewController") {
            print("segue...")
            let containerViewController: ContainerViewController = (segue.destinationViewController as? ContainerViewController)!
            let main = containerViewController.mainViewController! as! SelfFeedViewController
            main.tagName = self.tagName!.substringFromIndex(2)
        }
    }
}