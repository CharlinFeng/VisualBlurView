//
//  ViewController.swift
//  VisualBlureView
//
//  Created by 冯成林 on 15/12/31.
//  Copyright © 2015年 冯成林. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vbv: VisualBlurView!
    

}


extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 320, height: 200))
        label.text = "需要浪费大数据雷柏电动助力进入了哇"
        vbv.contentView.addSubview(label)

    }
    

}

