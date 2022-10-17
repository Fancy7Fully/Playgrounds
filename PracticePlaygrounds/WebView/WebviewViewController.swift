//
//  WebviewViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 10/16/22.
//

import Foundation
import UIKit
import WebKit

class WebviewViewController: UIViewController, WKNavigationDelegate {
  var webView: WKWebView = WKWebView()
  
  override func loadView() {
    webView.navigationDelegate = self
    self.view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = URL(string: "https://www.google.com")
    if let url = url {
      webView.load(URLRequest(url: url))
    }
    webView.allowsBackForwardNavigationGestures = true
  }
}
