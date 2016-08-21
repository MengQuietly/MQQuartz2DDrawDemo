//
//  MQDrawHistogramView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit
/** 5.绘制柱状图View（随机颜色／随机数组值） */
class MQDrawHistogramView: UIView {

    override func drawRect(rect: CGRect) {
        
        var x:CGFloat = 0
        var y:CGFloat = 0
        var w:CGFloat = 0
        var h:CGFloat = 0
        
        let array = MQCommonTool().arrayRandom()
        for item in 0..<array.count{
            print("\(array.count)===num = \(array[item])")
            w = rect.size.width / (2 * CGFloat(array.count) - 1)
            x = 2 * w * CGFloat(item)
            h = array[item] / 100.0 * rect.size.height
            y = rect.size.height - h
            
            let path = UIBezierPath(rect: CGRect(x: x, y: y, width: w, height: h))
            MQCommonTool().colorRandom().set()
            path.fill()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        setNeedsDisplay()
    }

}
