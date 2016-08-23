//
//  MQDrawStringAndImageView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 6.绘制文字／图片(drawAtPoint: 不换行,drawInRect: 自动换行) */
class MQDrawStringAndImageView: UIView {

    
    override func drawRect(rect: CGRect) {
        
        drawStr() // 绘制文字
        drawImage() // 绘制图片
        drawImageClip() // 绘制图片裁剪
    }
    
    // MARK: - 绘制图片裁剪(裁剪必须在绘制之前)
    func drawImageClip(){
        // 裁剪必须在绘制之前
        UIRectClip(CGRect(x: 50, y: 400, width: 80, height: 80))
        let img = UIImage(named: "3")
        img?.drawInRect(self.bounds)
    }
    
    // MARK: - 绘制图片(drawAtPoint: 原图尺寸,drawInRect: 缩放，drawAsPatternInRect：平铺)
    func drawImage(){
        let img = UIImage(named: "3")
//        // 默认绘制的内容尺寸与图片尺寸一样大
//        img?.drawAtPoint(CGPoint.zero)
//        img?.drawInRect(self.bounds)
//        img?.drawAsPatternInRect(self.bounds) // 平铺
        img?.drawAsPatternInRect(CGRect(x: 20, y: 150, width: 300, height: 200))
    }
    
    // MARK: - 绘制文字(drawAtPoint: 不换行,drawInRect: 自动换行)
    func drawStr(){
        let str:NSString = "诶比c滴一夫记七爱第二丝蒂语地一上课死实例我呢吧你波士顿说的话 i登上飞机上来了"
        
        // 阴影
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 1
        shadow.shadowColor = UIColor.redColor()
        shadow.shadowOffset = CGSize(width: 5, height: 5)
        
        let attr = [NSForegroundColorAttributeName:UIColor.blueColor(),NSFontAttributeName:UIFont.boldSystemFontOfSize(25),NSStrokeWidthAttributeName:5,NSStrokeColorAttributeName:UIColor.greenColor(),NSShadowAttributeName:shadow]
        
//        // 不换行
//        str.drawAtPoint(CGPoint.zero, withAttributes: attr)
        // 自动换行
        str.drawInRect(self.bounds, withAttributes: attr)
    }
}
