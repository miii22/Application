//
//  BrowseViewController.swift
//  Lookers!
//
//  Created by おのみ〜 on 2019/05/03.
//  Copyright © 2019 konoway. All rights reserved.
//
import UIKit

class BrowseViewController: UIViewController,UIWebViewDelegate {
    
    // 別ビューから受け取るリクエスト
    var request:URLRequest!
    
    // ウェブビュー
    var webView:UIWebView!
    
    // 「戻る」ボタンを配置するツールバー
    var toolbar:UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ウェブビューを画面いっぱいに作成
        webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        
        // URLリクエスト
        let req = URLRequest(url:request.url!)
        // ウェブビューにロード
        webView.loadRequest(req)
        // ウェブビューを表示
        self.view.addSubview(webView)
        
        // 「ホームへ戻る」ボタンの作成
        let button = UIButton(frame: CGRect(x:0,y:(self.view.bounds.height-40),width:self.view.bounds.width,height:40))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("ホームへ戻る", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(homeBack), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if navigationType == UIWebView.NavigationType.linkClicked {
            
            // ToolBarの制御
            if toolbar == nil {
                toolbar = UIToolbar(frame: CGRect(x:0,y:0,width:self.view.bounds.width,height:70))
                
                // Bar Button Item
                let img = UIImage(named:"BackArrow")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                let item = UIBarButtonItem(image: img,
                                           style: UIBarButtonItem.Style.plain,
                                           target: nil,
                                           action: #selector(BrowseViewController.backBrowse))
                let items = [item]
                toolbar?.items = items
                
                self.view.addSubview(toolbar!)
            }
        }
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if webView.isLoading {
            return
        }
        
        toolbar?.isHidden = true
        
        // 戻るボタン
        if self.webView.canGoBack {
            toolbar?.isHidden = false
        } else {
            toolbar?.isHidden = true
        }
    }
    
    @objc func backBrowse(){
        self.webView.goBack()
    }
    
    @objc func homeBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
