//
//  ViewController.swift
//  WKWebView_Test
//
//  Created by Kiroshan Thayaparan on 7/24/20.
//  Copyright © 2020 inoktechiis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textView: UITextView!
    var centerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createView(view: view)
        addDoneButtonOnKeyboard()
    }

    
    func createView(view: UIView) {
        centerView.removeFromSuperview()
        centerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 170))
        centerView.center = view.center
        view.addSubview(centerView)
        
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width-20, height: 100))
        textView.center.x = centerView.center.x
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 5.0
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.text = "Enter URL here"
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        
        centerView.addSubview(textView)
        
        let button = UIButton(frame: CGRect(x: 0, y: 120, width: view.frame.width/2, height: 50))
        button.center.x = centerView.center.x
        button.backgroundColor = .darkGray
        button.setTitle("View", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        centerView.addSubview(button)
    }
    
    
    @objc func buttonAction(sender: UIButton) {
        
        let text = textView.text
        
        if text == "" || text == "Enter URL here" {
            self.showToast(message: "Pleas enter the URL", font: .systemFont(ofSize: 12.0))
        } else {
            let web = WebViewModel(text: text!)
            
            let webView = WebViewController()
            webView.name = "My Page"
            webView.url = web.url
            webView.modalPresentationStyle = .fullScreen
            present(webView, animated: true, completion: nil)
            print(web.url)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textColor = .darkGray
        }
    }
       
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter URL here"
            textView.textColor = .gray
        }
    }
    
    func addDoneButtonOnKeyboard() {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textView.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.textView.resignFirstResponder()
        /* Or:
        self.view.endEditing(true);
        */
        let web = WebViewModel(text: textView.text)
        let webView = WebViewController()
        webView.name = "My Page"
        webView.url = web.url
        webView.modalPresentationStyle = .fullScreen
        present(webView, animated: true, completion: nil)
        print(web.url)
        
    }
}


extension UIViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
