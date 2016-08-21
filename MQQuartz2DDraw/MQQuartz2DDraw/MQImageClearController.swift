//
//  MQImageClearController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/10.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 13.图片擦除（pan手势，擦除图片） */
class MQImageClearController: UIViewController {

    @IBOutlet weak var clearV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        self.view.addGestureRecognizer(pan)
    }
    
    func panClick(pan:UIPanGestureRecognizer){
        // 获取擦除矩形范围
        let currentP = pan.locationInView(self.view)
        let wh:CGFloat = 30
        let x = currentP.x - wh * 0.5
        let y = currentP.y - wh * 0.5
        let rect = CGRect(x: x, y: y, width: wh, height: wh)
        
        // 获取上下文
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        // 将控件 layer 渲染上去
        self.clearV.layer.renderInContext(ctx!)
        // 擦除图片
        CGContextClearRect(ctx, rect)
        
        self.clearV.image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
