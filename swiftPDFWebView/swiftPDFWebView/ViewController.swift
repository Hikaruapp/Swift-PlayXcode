//
//  ViewController.swift
//  swiftPDFWebView
//
//  Created by Yanase Yuji on 2017/05/01.
//  Copyright © 2017年 hikaruApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myWebView.scalesPageToFit = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // URL
    @IBAction func buttonUrl(_ sender: Any) {
        if let url = URL(string: "https://..../guide.pdf") {
            myWebView.loadRequest(URLRequest(url: url))
        }
    }

    // Bundle
    @IBAction func buttonBundle(_ sender: Any) {
        if let pdfFilePath = Bundle.main.path(forResource: "guide", ofType: "pdf") {
            myWebView.loadRequest(URLRequest(url: URL(string: pdfFilePath)!))
        }
    }
}
