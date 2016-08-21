//
//  MQDrawCaputureController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/9.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 12.图片截取（pan手势，绘制图片裁剪区，裁剪图片） */
class MQDrawCaputureController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    var startP = CGPointZero
    var endP = CGPointZero
    
    private lazy var rectView : UIView = {
        let rectViews = UIView()
        rectViews.backgroundColor = UIColor.blackColor()
        rectViews.alpha = 0.5
        return rectViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        self.view.addGestureRecognizer(pan)
    }
    
    func panClick(pan:UIPanGestureRecognizer){
        if pan.state == UIGestureRecognizerState.Began {
            startP = pan.locationInView(self.view)
        } else if (pan.state == UIGestureRecognizerState.Changed) {
            endP = pan.locationInView(self.view)
            let w = endP.x - startP.x
            let h = endP.y - startP.y
            let rect = CGRect(x: startP.x, y: startP.y, width: w, height: h)
            // 绘制裁剪区View
            self.rectView.frame = rect
            self.view.addSubview(rectView)
        } else if (pan.state == UIGestureRecognizerState.Ended) {
            // 图片裁剪
            UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, false, 0)
            let clipPath = UIBezierPath(rect: self.rectView.frame)
            clipPath.addClip()
            let ctx = UIGraphicsGetCurrentContext()
            // 将控件 layer 渲染上去
            imageV.layer.renderInContext(ctx!)
            imageV.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // 移除裁剪区View
            self.rectView.removeFromSuperview()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
