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
        
        // 認証URLを取得する.
        let authorizationUrl : NSURL = engine.authorizationURL()
        
        // 認証URLをログ出力する.
        print(authorizationUrl)
        
        // リクエストを作成する.
        let urlRequest: NSURLRequest = NSURLRequest(URL: authorizationUrl)
        
        do {
            // 認証済みの場合AccessTokenを取得する
            try engine.receivedValidAccessTokenFromURL(urlRequest.URL)
            
            print("success to get access token.")
            
            // 遷移先のUIViewControllerを生成する.
            let selfFeedViewController: UIViewController = SelfFeedViewController()
            
            // アニメーションを設定する.
            selfFeedViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
            
            // Viewを移動する.
            self.presentViewController(selfFeedViewController, animated: true, completion: nil)
            
            
        } catch {
            
            // 認証画面を表示する.
            self.displayAuthenticationPage()
            
            print("fail to get access token.")
            print(error)
            
        }
        
        print("***** viewDidLoad end.   *****")
        
    }
    
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        
//        print("**** webView start")
//        do {
//            // 認証済みの場合AccessTokenを取得する
//            try engine.receivedValidAccessTokenFromURL(request.URL)
//            
//            print("success to get access token.")
//            
//            // 認証画面は表示しない.
//            return false
//          
//        } catch {
//            
//            print("fail to get access token.")
//            print(error)
//        
//        }
//        
//        print("**** webView end")
//        return true
//    }
    
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
    webviewがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad")
        
        // ローディングを終了する。
        MRProgressOverlayView.dismissOverlayForView(self.view, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

