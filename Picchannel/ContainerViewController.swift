//
//  ContainerViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2016/04/02.
//  Copyright © 2016年 ktp. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ContainerViewController: SlideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load Container")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("SelfFeed") {
            self.mainViewController = controller
            print("load SelfFeed.")
        }
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("SwipeMenu") {
            self.leftViewController = controller
            print("load SwipeMenu.")
        }
        super.awakeFromNib()
    }
}
