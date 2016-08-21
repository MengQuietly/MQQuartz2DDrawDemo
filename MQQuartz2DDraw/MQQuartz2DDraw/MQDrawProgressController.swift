//
//  MQDrawProgressController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 3.拖拽Slider，绘制进度条 */
class MQDrawProgressController: UIViewController {

    @IBOutlet weak var progressView: MQDrawProgressView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBAction func sliderChange(sender: UISlider) {
        
        let progress = String(format: "%.2f", sender.value * 100)
        progressLabel.text = "\(progress)%"
        progressView.progressNum = Double(sender.value)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
