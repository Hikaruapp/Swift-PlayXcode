//
//  AlertUIViewController.swift
//  SelfView
//
//  Copyright © 2017年 hikaruApp. All rights reserved.
//

import UIKit

class AlertUIViewController {
    func alert( message: String, myview: UIViewController) {
        
        // アラートを作成
        let myAlert = UIAlertController(title: "UIViewController", message: message, preferredStyle: .alert)
        
        // アラートにボタンをつける
        myAlert.addAction(UIAlertAction(title: "OK", style: .default))
        
        // アラート表示
        myview.present(myAlert, animated: true, completion: nil)
        
    }
}

