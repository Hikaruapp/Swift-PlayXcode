//
//  AlertExtension.swift
//  SelfView
//
//  Copyright © 2017年 hikaruApp. All rights reserved.
//

import UIKit

protocol AlertExtension {
    func alertExtention()
}

extension ViewController: AlertExtension {
    
    func alertExtention() {
        
        // アラートを作成
        let myAlert = UIAlertController(title: "Extension", message: mymessage, preferredStyle: .alert)
        
        // アラートにボタンをつける
        myAlert.addAction(UIAlertAction(title: "OK", style: .default))
        
        // アラート表示
        self.present(myAlert, animated: true, completion: nil)
    }
    
}
