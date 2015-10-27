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
    var mediaUrls : [NSURL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ローディングを開始する。
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true);

            let engine: InstagramEngine = InstagramEngine.sharedEngine()
            
            // 人気の画像を取得する.
            engine.getPopularMediaWithSuccess({ media, paginationInfo in
                
                // 成功の場合
                print("success get media.")
                
                for m in media {
                    
                    // 画像URLを出力する.
                    print(m.lowResolutionImageURL)
                    
                    self.mediaUrls.append(m.lowResolutionImageURL)
                }
                
                // 非同期処理完了後にurl画像を表示
                self.dispayMedia()
                
                // ローディングを終了する。
                MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
                
                
            },failure: { error, serverStatusCode in
                
                // 失敗の場合
                print("failure get media.")
                
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dispayMedia(){
        
        var y: CGFloat = 0
        
        do {
        
            for i in 0...(mediaUrls.count - 1) {
                
                // urlから画像を取得する.
                let imageData :NSData = try NSData(contentsOfURL: mediaUrls[i] ,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
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
}

