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
            // 画像urlを設定する.
            var urls : [String] = [
                "https://scontent.cdninstagram.com/hphotos-xfa1/t51.2885-15/s320x320/e35/12070661_1728238167404162_154574692_n.jpg",
                "https://scontent.cdninstagram.com/hphotos-xfa1/t51.2885-15/s320x320/e35/11337185_773036789492157_1799302479_n.jpg",
                "https://scontent.cdninstagram.com/hphotos-xfa1/t51.2885-15/s320x320/e35/12093269_1664014217215940_2028057166_n.jpg"
            ]
            
            var y: CGFloat = 0
            
            for i in 0...(urls.count - 1) {
                
                // urlから画像を取得する.
                let url = NSURL(string: urls[i]);
                let imageData :NSData = try NSData(contentsOfURL: url! ,options: NSDataReadingOptions.DataReadingMappedIfSafe)

                // UIImageに画像を設定する.
                let myImage = UIImage(data: imageData)!
                
                // UIImageViewを生成する.
                let myImageView = UIImageView()
                
                // myImageViewのimageにmyImageを設定する.
                myImageView.image = myImage
                
                // frameの値を設定する.
                myImageView.frame = CGRectMake(0, y, myImage.size.width, myImage.size.height)
                
                // ScrollViewにmyImageViewを追加する.
                scrollView.addSubview(myImageView)
                
                // 画像サイズを取得する.
                y += myImage.size.height + 0.5
                
                // ScrollViewにcontentSizeを設定する.
                scrollView.contentSize = CGSizeMake(myImageView.frame.size.width, y)
                
            }
            
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

