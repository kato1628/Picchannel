//
//  SelfFeedViewController.swift
//  Picchannel
//
//  Created by Hiroshi Kato on 2015/11/14.
//  Copyright © 2015年 ktp. All rights reserved.
//

import UIKit

class SelfFeedViewController: UIViewController,MNMBottomPullToRefreshManagerClient, UITableViewDataSource, UITableViewDelegate{
    
    // @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var selfFeedTable: UITableView!
    
    var mediaUrls : [NSURL] = []
    let engine: InstagramEngine = InstagramEngine.sharedEngine()
    var medias: [InstagramMedia] = []
    var refreshControl: UIRefreshControl!
    var nextMaxId: NSString = ""
    var refreshCount: Int = 0
    var refreshManager: MNMBottomPullToRefreshManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("display self feed start")
        
        // ローディングを開始する.
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true);
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        selfFeedTable.addSubview(refreshControl)
        
        self.refreshManager = MNMBottomPullToRefreshManager(pullToRefreshViewHeight: 60.0, tableView: selfFeedTable, withClient: self)
        
        // タイムラインの画像URLを取得する.
        self.getSelfFeed()
        
        print("display self feed end")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // viewのロード後インディケーターをoffにする.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        print("indicator off")
    }
    
    // TableViewのセルの数を指定
    func tableView(selfFeedTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("medias count\(medias.count)")
        return medias.count
    }
    
    // TableViewの画像を指定
    func tableView(selfFeedTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("table view start \(indexPath.row)")
        
        // tableCellのIDでUITableViewCellのインスタンスを生成
        let cell = selfFeedTable.dequeueReusableCellWithIdentifier("mediaCell", forIndexPath: indexPath)

        // tableViewのUIImageに画像を設定する.
        let imageView = selfFeedTable.viewWithTag(1) as! UIImageView
        imageView.sd_setImageWithURL(self.medias[indexPath.row].standardResolutionImageURL)
        
        // tableViewのUILabelに取得したユーザ名を設定する.
        let userNameLabel = selfFeedTable.viewWithTag(2) as! UILabel
        userNameLabel.text = "@" + self.medias[indexPath.row].user.username
        
        // tableViewのUILabelに取得したユーザ名を設定する.
        let captionLabel = selfFeedTable.viewWithTag(3) as! UILabel
        captionLabel.text = self.medias[indexPath.row].caption.text
        
        return cell
    }
    
    // リフレッシュ時の処理
    func refresh() {
        print("refresh start.")
        engine.getSelfFeedWithCount(refreshCount, maxId: self.nextMaxId as String, success: { media, painationInfo in
            
            print(media.count)
            
            if media.count > 0 {
 
                print("media update.")

                for (index, m) in media.enumerate() {
                    print(index)
                    print(m.standardResolutionImageURL)
                    self.medias.append(m as! InstagramMedia)
                }
                
                print(self.medias.count)
                self.selfFeedTable.reloadData()
                
            } else {
                print("no media update.")
            }
            
            self.nextMaxId = painationInfo.nextMaxId
            self.refreshControl.endRefreshing()
            
            }, failure: { error, serverStatusCode in
                
                print(error)
                self.refreshControl.endRefreshing()
        })
        print("refresh end.")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.refreshManager.tableViewScrolled()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.refreshManager.tableViewReleased()
    }
    
    func bottomPullToRefreshTriggered(manager :MNMBottomPullToRefreshManager) {
        self.refresh()
    }
    
    /*
    自分のフィードの画像URLを取得する.
    */
    func getSelfFeed(){
        
        print("start get self feed")
        
        engine.getSelfFeedWithSuccess({ media, paginationInfo in
            
            // 成功の場合
            print("success get self media.\(paginationInfo.nextMaxId)")
            
            self.medias = media as! [InstagramMedia]
            self.refreshCount = self.medias.count
            self.nextMaxId = paginationInfo.nextMaxId
            
            for m in self.medias {
                
                // 画像URLを取得する.
                print(m.standardResolutionImageURL)
                print(m.thumbnailURL)
                print(paginationInfo)
                
            }

            self.selfFeedTable.reloadData()
            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.selfFeedTable.reloadData()
//            })
            
            // ローディングを終了する。
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true);
            
            print("finished getting self media.")
            
            },failure: { error, serverStatusCode in
                
                // 失敗の場合
                print(error)
                print("failure get self media.")
                
        })
    }
    
    /*
    自分のフィードの画像を表示する.
    */
    func displaySelfFeed(){
        
        engine.getSelfFeedWithSuccess({ media, paginationInfo in
            
            // 成功の場合
            print("success get self media.")
            
            for m in media {
                
                // 画像URLを取得する.
                self.mediaUrls.append(m.lowResolutionImageURL)
            }
            
            // 非同期処理完了後にurl画像を表示
            self.dispayMedia()
            
            // ローディングを終了する。
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true);
            
            print("finished loading.")
            
            },failure: { error, serverStatusCode in
                
                // 失敗の場合
                print(error)
                print("failure get self media.")
                
        })
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
    画像一覧を表示する
    */
    func dispayMedia(){
        
        var y: CGFloat = 20
        
        do {
            
            for url in self.mediaUrls {
                
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
                // scrollView.addSubview(myImageView)
                
                // 画像サイズを取得する.
                y += myImage.size.height + 0.5
                
                // ScrollViewにcontentSizeを設定する.
                // scrollView.contentSize = CGSizeMake(myImageView.frame.size.width, y)
                
            }
            
        } catch {
            // error出力
            print(error)
            print("error has occurred.")
            return
        }
    }
    
}

