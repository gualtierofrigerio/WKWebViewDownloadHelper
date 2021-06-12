//
//  ViewController.swift
//  WkWebViewTest
//
//  Created by Gualtiero Frigerio on 03/07/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import UIKit
import WebKit
import WKDownloadHelper

class ViewController: UIViewController {
    var webView:WKWebView!
    //var helper:WKWebviewDownloadHelper!
    var downloadHelper: WKDownloadHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let mimeTypes = [MimeType(type: "ms-excel", fileExtension: "xls"),
                         MimeType(type: "pdf", fileExtension: "pdf")]
        //helper = WKWebviewDownloadHelper(webView: webView, mimeTypes:mimeTypes, delegate: self)
        downloadHelper = WKDownloadHelper(webView: webView, supportedMimeTypes: mimeTypes, delegate: self)
        let request = URLRequest(url: URL(string: "https://www.google.it")!)
        webView.load(request)
        self.webView = webView
        self.navigationItem.title = "My Page"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
    }
}

// OLD implementation
//extension ViewController: WKWebViewDownloadHelperDelegate {
//    func fileDownloadedAtURL(url: URL) {
//        DispatchQueue.main.async {
//            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//            activityVC.popoverPresentationController?.sourceView = self.view
//            activityVC.popoverPresentationController?.sourceRect = self.view.frame
//            activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
//            self.present(activityVC, animated: true, completion: nil)
//        }
//    }
//}

extension ViewController: WKDownloadHelperDelegate {
    func canNavigate(toUrl: URL) -> Bool {
        true
    }
    
    func didFailDownloadingFile(error: Error) {
        print("error while downloading file \(error)")
    }
    
    func didDownloadFile(atUrl: URL) {
        print("did download file!")
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [atUrl], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.sourceRect = self.view.frame
            activityVC.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(activityVC, animated: true, completion: nil)
        }
    }
}
