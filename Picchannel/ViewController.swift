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
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // ログインナビゲーションを閉じる.
        navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var webView: UIWebView!

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
            let containerViewController: UIViewController = ContainerViewController()
            
            // アニメーションを設定する.
            containerViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
            
            // Viewを移動する.
            self.presentViewController(containerViewController, animated: true, completion: nil)
            
            
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
        webView.delegate = self
        
        // WebViewのサイズを設定する.
        webView.frame = self.view.bounds
        
        // Viewに追加する.
        self.view.addSubview(webView)
        
        // 認証URLを取得する.
        let authorizationUrl : NSURL = engine.authorizationURL()
        
        // 認証URLをログ出力する.
        print(authorizationUrl)
        
        // リクエストを作成する.
        let urlRequest: NSURLRequest = NSURLRequest(URL: authorizationUrl)
        
        // リクエストを実行する.
        webView.loadRequest(urlRequest)
        
    }
    
    /*
    webviewが読み込まれ始める時呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        print("indicator on")
    }
    
    /*
    webviewがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        print("indicator off")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

