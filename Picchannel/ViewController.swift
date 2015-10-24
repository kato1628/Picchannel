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
        
        do {
            // urlから画像を取得
            let url = NSURL(string: "https://scontent.cdninstagram.com/hphotos-xfa1/t51.2885-15/s640x640/sh0.08/e35/12139835_481785788659634_1326639266_n.jpg");
            
            let imageData :NSData = try NSData(contentsOfURL: url! ,options: NSDataReadingOptions.DataReadingMappedIfSafe)

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
            
        } catch {
            // error出力
            print(error)
            print("error has occurred.")
            return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

