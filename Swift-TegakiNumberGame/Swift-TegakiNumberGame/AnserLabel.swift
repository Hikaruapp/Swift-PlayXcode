//
//  AnserLabel.swift
//  tegaki
//
//  Created by Yanase Yuji on 2016/11/06.
//  Copyright © 2016年 hikaruApp. All rights reserved.
//

import UIKit

class AnserLabel: UILabel {

    func clear() {
        text = "-"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clear()
    }
}
