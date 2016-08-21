//
//  MQDrawImageUseController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/9.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/// 11.图片操作(UIGraphicsBeginImageContextWithOptions 位图上下文：与View无关联，所以不需要在 drawRect 方法中获取)（截屏：layer 只能渲染,使用renderInContext）
class MQDrawImageUseController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        drawImageWithWaterMark() // 11.图片水印
//        drawImageWithClip() // 12.图片裁剪(无边框)
//        drawImageWithClip2() // 13.图片裁剪(带边框)
        
        // 图片裁剪(是否带边框)
        imageV.image = UIImage().clipImage(UIImage(named: "1")!, border: 0, borderColor: UIColor.greenColor())
    }
    
    // MARK: - 13.图片截屏（layer 只能渲染,使用renderInContext）
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // compressionQuality:图片质量（1:最高质量）
        let img = UIImage().caputureView(caputureViews: self.view)
        let data = UIImageJPEGRepresentation(img, 0.0001)
        data?.writeToFile("/Users/txcap/Desktop/v.png", atomically: true)
        
    }
    
    
    // MARK: - 12.图片裁剪(无边框)
    func drawImageWithClip(){
        let img = UIImage(named: "3")
        // 1.开启位图上下文(应与图片尺寸一样大)
        UIGraphicsBeginImageContextWithOptions((img?.size)!, false, 0)
        
        // 2.设置图形裁剪区(正切图片)
        // 1)绘制圆形路径
        let path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: (img?.size.width)!, height: (img?.size.height)!))
        // 2)把路径设置为裁剪区
        path.addClip()
        
        // 3.绘制图片
        img?.drawAtPoint(CGPoint.zero)
        
        // 4.获取新图片
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        
        imageV.image = newImg
    }
    
    // MARK: - 11.图片水印
    func drawImageWithWaterMark(){
        let img = UIImage(named: "1")
        /// 1.开启位图上下文
        /// size:新图片尺寸；opaque:是否不透明；scalse:缩放值(0-1)
        UIGraphicsBeginImageContextWithOptions((img?.size)!, false, 0)
        /// 2.绘制图文
        img?.drawAtPoint(CGPoint.zero)
        let str:NSString = "萌萌吖头"
        let strAtt:[String:AnyObject] = [
            NSForegroundColorAttributeName:UIColor.redColor(),
            NSFontAttributeName:UIFont.systemFontOfSize(24)
        ]
        str.drawAtPoint(CGPoint(x: 185,y: 180), withAttributes: strAtt)
        /// 3.获取新图片
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        /// 4.关闭上下文
        UIGraphicsEndImageContext()
        imageV.image = newImg
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
