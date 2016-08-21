//
//  MQDrawProgressView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 进度条展示 View  */
class MQDrawProgressView: UIView {

    var progressNum = 0.00 {
        didSet{
            // 重绘，系统会先创建与 View 相关联的上下文
            setNeedsDisplay()
        }
    }

    // MARK: - drawRect 不能手动调用，因为图形上下文只能由系统创建，并传递给我们
    override func drawRect(rect: CGRect) {
        let radius = rect.size.width * 0.5
        let center = CGPoint(x: radius, y: radius)
        let endAngle = -M_PI_2 + progressNum * M_PI * 2
        let path = UIBezierPath(arcCenter: center, radius: radius - 2, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(endAngle), clockwise: true)
        
        path.stroke()
    }
    

}
