//
//  MQDrawPieView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 4.绘制饼图View（随机颜色／随机数组值） */
class MQDrawPieView: UIView {

    override func drawRect(rect: CGRect) {
        
        let radius = rect.size.width * 0.5
        let center = CGPoint(x: radius, y: radius)
        
        var startA:CGFloat = 0
        var angle:CGFloat = 0
        var endA:CGFloat  = 0
        
        let array = MQCommonTool().arrayRandom()
        for item in array {
            startA = endA
            angle = item / 100 * CGFloat(M_PI) * 2
            endA = startA + angle
            let path = UIBezierPath(arcCenter: center, radius: radius - 2, startAngle: startA, endAngle: endA, clockwise: true)
            path.addLineToPoint(center)
            MQCommonTool().colorRandom().set()
            path.fill()
        }
    }
    
    // MARK: - 点击重绘
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        setNeedsDisplay()
    }

}
