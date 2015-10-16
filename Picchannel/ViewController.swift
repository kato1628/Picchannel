//
//  ViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2015/10/16.
//  Copyright © 2015年 ktp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // urlから画像を取得
        let url = NSURL(string: "http://chocobit.com/blog/wp-content/uploads/2007/01/panorama.jpg");
        let imageData :NSData = try! NSData(contentsOfURL: url! ,options: NSDataReadingOptions.DataReadingMappedIfSafe)
        
        // UIImageに画像を設定する.
        let myImage = UIImage(data: imageData)!
        
        // UIImageViewを生成する.
        let myImageView = UIImageView()
        
        // myImageViewのimageにmyImageを設定する.
        myImageView.image = myImage
        
        // frameの値を設定する.
        myImageView.frame = CGRectMake(0, 0, myImage.size.width, myImage.size.height)
        
        // ScrollViewにmyImageViewを追加する.
        scrollView.addSubview(myImageView)
        
        // ScrollViewにcontentSizeを設定する.
        scrollView.contentSize = CGSizeMake(myImageView.frame.size.width, myImageView.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

