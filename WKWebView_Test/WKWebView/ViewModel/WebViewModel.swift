//
//  WebViewModel.swift
//  WKWebView_Test
//
//  Created by Kiroshan Thayaparan on 7/25/20.
//  Copyright © 2020 inoktechiis. All rights reserved.
//

import Foundation


class WebViewModel {
    
    private var webModel: WebModel
    
    init(text: String) {
        self.webModel = WebModel.init(text: text)
    }
    
    var url: URL {
        var url = URL(string: webModel.text!)
        if url == nil {
            url = URL(string: "https://www.google.com/")
        }
        return url!
    }
}
