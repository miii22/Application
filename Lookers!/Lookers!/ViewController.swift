//
//  ViewController.swift
//  Lookers
//
//  Created by おのみ〜 on 2019/04/29.
//  Copyright © 2019 konoway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // インスタンス配列
    var controllerArray : [UIViewController] = []
    var pageMenu : CAPSPageMenu?
    var request:URLRequest?
    
    // サイト情報
    let siteInfo:[Dictionary<String,String>] = [
        ["title":"Qiita","url":"https://qiita.com/"],
        ["title":"connpass","url":"https://connpass.com/"],
        ["title":"speakerdeck","url":"https://speakerdeck.com/"],
        ["title":"teratail","url":"https://teratail.com/"],
        ["title":"stackoverflow","url":"https://stackoverflow.com/"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for site in siteInfo {
            
            let controller:ContentsViewController = ContentsViewController(nibName: "ContentsViewController", bundle: nil)
            
            controller.title = site["title"]!
            controller.siteUrl = site["url"]!
            
            controller.webView = UIWebView(frame : self.view.bounds)
            controller.webView.delegate = controller
            controller.view.addSubview(controller.webView)
            let req = URLRequest(url: URL(string:controller.siteUrl!)!)
            controller.webView.loadRequest(req)
            controllerArray.append(controller)
            
        }
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.blue),
            .selectionIndicatorColor(UIColor.red),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 14.0)!),
            .centerMenuItems(true),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .menuMargin(16),
            .selectedMenuItemLabelColor(UIColor.black),
            .unselectedMenuItemLabelColor(UIColor.gray)
            
        ]
        
        // Initialize scroll menu
        
        let rect = CGRect(origin: CGPoint(x: 0,y :20), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: rect, pageMenuOptions: parameters)
        
        self.addChild(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParent: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func browse(_ request:URLRequest) {
        self.request = request
        performSegue(withIdentifier: "browse", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "browse" {
            let vc = segue.destination as! BrowseViewController
            vc.request = self.request
        }
    }
}
