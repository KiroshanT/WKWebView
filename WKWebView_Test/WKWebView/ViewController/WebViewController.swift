//
//  WebViewController.swift
//  WKWebView_Test
//
//  Created by Kiroshan Thayaparan on 7/25/20.
//  Copyright © 2020 inoktechiis. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: UIViewController {
    
    var name: String?
    var url: URL?
    
    var webView: WKWebView!
    
    var headerView = UIView()
    var contentView = UIView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        webSetup(url: url!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createView(view: view)
    }
    
    func createView(view: UIView) {
        
        headerView.removeFromSuperview()
        contentView.removeFromSuperview()
        
        headerView = UIView(frame: CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 30))
        headerView.backgroundColor = .darkGray
        view.addSubview(headerView)
        
        backButton = UIButton(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        backButton.setImage(UIImage(named: "arrow_left_white"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        headerView.addSubview(backButton)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 5, width: view.frame.width, height: 20))
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = name
        headerView.addSubview(titleLabel)
        
        contentView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+30, width: view.frame.width, height: view.frame.height-(view.safeAreaInsets.top+30))
        view.addSubview(contentView)
    }
    
    func webSetup(url: URL) {
        
        webView = WKWebView()
        contentView = webView
        webView.load(URLRequest(url: url))
        webView.configuration.preferences.javaScriptEnabled = true
        webView.allowsBackForwardNavigationGestures = true
        webView.isUserInteractionEnabled = true
        webView.allowsLinkPreview = true
    }
    
    @objc func backButtonAction(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
