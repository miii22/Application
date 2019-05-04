//
//  ContentsViewController.swift
//  Lookers!
//
//  Created by おのみ〜 on 2019/05/03.
//  Copyright © 2019 konoway. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController ,UIWebViewDelegate{
    
    var webView:UIWebView!
    var siteUrl:String!
    
    var masterViewPointer:ViewController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Webview delegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        if navigationType == UIWebView.NavigationType.linkClicked {
            masterViewPointer?.browse(request)
            return false
        }
        
        return true
    }
    
}
