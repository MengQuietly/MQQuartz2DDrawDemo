//
//  UIImage+Extensions.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/9.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

// MARK: - UIImage 分类
extension UIImage {
    
    /// 图片裁剪(带边框)
    func clipImage(clipImage:UIImage,border:CGFloat,borderColor:UIColor?)->UIImage{
        
        // 图片裁剪区宽高
        let imgClipWH = min(clipImage.size.width,clipImage.size.height)
        // 边框圆宽高
        let ovalWH = imgClipWH + 2 * border
        
        // 1.开启位图上下文(应比图片尺寸一样大)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: ovalWH,height: ovalWH), false, 0)
        // 2. 绘制圆环
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: ovalWH, height: ovalWH))
        if border > 0 {
            ovalPath.lineWidth = border
            UIColor.redColor().set()
            if borderColor != nil{
                borderColor!.set()
            }
        }
        ovalPath.fill()
        
        // 2.设置图形裁剪区(正切图片)
        // 1)绘制圆形路径
        let imgClipPath = UIBezierPath(ovalInRect: CGRect(x: border, y: border, width: imgClipWH, height: imgClipWH))
        // 2)把路径设置为裁剪区
        imgClipPath.addClip()
        
        // 3.绘制图片
        clipImage.drawAtPoint(CGPoint(x: border, y: border))
        
        // 4.获取新图片
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5.关闭上下文
        UIGraphicsEndImageContext()
        
        return newImg
    }
    
    // MARK: - 截屏（layer 只能渲染,使用renderInContext）
    func caputureView(caputureViews caputureViews:UIView)->UIImage{
        
        // 1.开启位图上下文
        UIGraphicsBeginImageContextWithOptions(caputureViews.bounds.size, false, 0)
        // 2.获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        // 3.把控件上的图层渲染到上下文（layer 只能渲染,使用renderInContext）
        caputureViews.layer.renderInContext(ctx!)
        
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        // 4.关闭上下文
        UIGraphicsEndImageContext()
        
        return newImg
    }

    
}