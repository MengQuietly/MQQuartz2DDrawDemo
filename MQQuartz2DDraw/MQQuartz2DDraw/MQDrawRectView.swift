//
//  MQDrawRectView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/2.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 2.绘制形状View（填充fill：必须是一个完整的封闭路径，默认会自动关闭路径） */
class MQDrawRectView: UIView {

    override func drawRect(rect: CGRect) {
        
        
        quadCurVeLine()
    }
    
    // MARK: - 圆角矩形绘制
    func quadCurVeLine(){
        
//        // 圆角矩形绘制
//        let path = UIBezierPath(roundedRect: CGRect(x: 20,y: 20,width: 200,height: 200), cornerRadius: 10)
//        
//        // 圆形绘制
//        let path = UIBezierPath(ovalInRect: CGRect(x: 100, y: 100, width: 100, height: 100))
//        
//        // 圆弧绘制
//        let path = UIBezierPath(arcCenter: CGPoint(x: 125,y: 125), radius: 100, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
        
        // 扇形绘制(clockwise:是否逆时针)
        let center = CGPoint(x: 125,y: 125)
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: -CGFloat(M_PI_2), clockwise: false)
        path.addLineToPoint(center)
        path.closePath() // 封闭路径
        
        path.fill()
    }
}
