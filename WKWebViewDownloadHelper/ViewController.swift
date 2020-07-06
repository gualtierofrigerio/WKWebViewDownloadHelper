//
//  ViewController.swift
//  WkWebViewTest
//
//  Created by Gualtiero Frigerio on 03/07/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView:WKWebView!
    var helper:WKWebviewDownloadHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        helper = WKWebviewDownloadHelper(webView: webView, mimeTypes: ["ms-excel"], delegate: self)
        let request = URLRequest(url: URL(string: "https://st.catflow.it")!)
        webView.load(request)
        self.webView = webView
        self.navigationItem.title = "My Page"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
    }
}

extension ViewController: WKWebViewDownloadHelperDelegate {
    func fileDownloadedAtURL(url: URL) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.sourceRect = self.view.frame
            activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
