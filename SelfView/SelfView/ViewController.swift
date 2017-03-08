//
//  ViewController.swift
//  SelfView
//
//  Copyright © 2017年 hikaruApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mymessage = "おっす！！"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonUiview(_ sender: Any) {
        
        let alert = AlertUIViewController()
        alert.alert(message: mymessage, myview: self)
        
    }
    
    @IBAction func buttonExtension(_ sender: Any) {
        alertExtention()
    }
}

