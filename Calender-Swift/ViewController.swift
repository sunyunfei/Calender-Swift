//
//  ViewController.swift
//  Calender-Swift
//
//  Created by 孙云 on 16/4/13.
//  Copyright © 2016年 haidai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showView:CalenderView = CalenderView.createView() as! CalenderView
        showView.frame = self.view.bounds
        self.view.addSubview(showView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

