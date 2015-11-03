//
//  ViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2015/10/16.
//  Copyright © 2015年 ktp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var mediaUrls : [NSURL] = []
    var webview: UIWebView = UIWebView()
    let engine: InstagramEngine = InstagramEngine.sharedEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("***** viewDidLoad start. *****")
        
        // ローディングを開始する.
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true);
        
        // 認証画面を表示する.
        self.displayAuthenticationPage()

        // 人気の画像を表示する.
        // self.dispayPopularMedia()
        
        print("***** viewDidLoad end.   *****")
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("**** webView start")
        do {
            // 認証済みの場合AccessTokenを取得する
            try engine.receivedValidAccessTokenFromURL(request.URL)
            
            print("success to get access token.")
            
            // ユーザのフィードを表示する.
            self.displaySelfFeed()
            
            return false
            
        } catch {
            
            print("fail to get access token.")
            print(error)
        
        }
        
        print("**** webView end")
        return true
    }
    
    /*
    認証画面を表示する
    */
    func displayAuthenticationPage(){
        
        // Delegateを設定する.
        webview.delegate = self
        
        // WebViewのサイズを設定する.
        webview.frame = self.view.bounds
        
        // Viewに追加する.
        self.view.addSubview(webview)
        
        // 認証URLを取得する.
        let authorizationUrl : NSURL = engine.authorizationURL()
        
        // 認証URLをログ出力する.
        print(authorizationUrl)
        
        // リクエストを作成する.
        let urlRequest: NSURLRequest = NSURLRequest(URL: authorizationUrl)
        
        // リクエストを実行する.
        webview.loadRequest(urlRequest)
        
    }
    
    /*
    人気の画像を取得し表示する.
    */
    func dispayPopularMedia(){
        
        engine.getPopularMediaWithSuccess({ media, paginationInfo in
            
            // 成功の場合
            print("success get media.")
            
            for m in media {
                
                // 画像URLを取得する.
                self.mediaUrls.append(m.lowResolutionImageURL)
            }
            
            // 非同期処理完了後にurl画像を表示
            self.dispayMedia()
            
            // ローディングを終了する。
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true);
            
            },failure: { error, serverStatusCode in
                
                // 失敗の場合
                print(error)
                print("failure get media.")
                
        })
        
    }

    /*
    自分のフィードの画像を表示する.
    */
    func displaySelfFeed(){
        
        // ローディングを開始する.
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true);
        
        engine.getSelfFeedWithSuccess({ media, paginationInfo in
            
            // 成功の場合
            print("success get self media.")
            
            for m in media {
                
                // 画像URLを取得する.
                print(m.lowResolutionImageURL)
                self.mediaUrls.append(m.lowResolutionImageURL)
            }
            
            // 非同期処理完了後にurl画像を表示
            self.dispayMedia()
            
            // ローディングを終了する。
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true);
            
            },failure: { error, serverStatusCode in
                
                // 失敗の場合
                print(error)
                print("failure get self media.")
                
        })
    }
    
    /*
    画像一覧を表示する
    */
    func dispayMedia(){
        
        var y: CGFloat = 0
        
        do {
        
            for url in mediaUrls {
                
                // urlから画像を取得する.
                let imageData :NSData = try NSData(contentsOfURL: url ,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
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
    
    /*
    webviewがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

