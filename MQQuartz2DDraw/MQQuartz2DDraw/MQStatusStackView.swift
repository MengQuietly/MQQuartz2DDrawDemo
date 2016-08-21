//
//  MQStatusStackView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/5.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 9.上下文状态栈（CGContextSaveGState：保存上下文状态栈；CGContextRestoreGState：还原上下文状态线 ） */
class MQStatusStackView: UIView {

    override func drawRect(rect: CGRect) {
//        pathUseToDo()
//        pathWithCGUseToDo()
        pathWithCGUseToDo2()
        
    }
    
    // MARK: - path+Graphics 上下文状态栈 做法三：A线／B线 上下文描述已分离
    func pathWithCGUseToDo2(){
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // 第一条
        var path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 50, y: 125))
        path.addLineToPoint(CGPoint(x: 240, y: 125))
        CGContextAddPath(ctx, path.CGPath)
        CGContextSaveGState(ctx) // 保存上下文状态栈（之后的上下文描述不做保存）

        CGContextSetLineWidth(ctx, 10)
        UIColor.redColor().set()
        CGContextStrokePath(ctx)
        
        // 第二条
        path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 150, y: 50))
        path.addLineToPoint(CGPoint(x: 150, y: 240))
        CGContextAddPath(ctx, path.CGPath)
        CGContextRestoreGState(ctx) // 还原上下文状态线
        CGContextStrokePath(ctx)
    }

    
    // MARK: - path+Graphics 做法二：A线／B线 上下文描述已分离
    func pathWithCGUseToDo(){
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // 第一条
        var path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 50, y: 125))
        path.addLineToPoint(CGPoint(x: 240, y: 125))
        
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, 10)
        UIColor.redColor().set()
        CGContextStrokePath(ctx)
        
        // 第二条
        path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 150, y: 50))
        path.addLineToPoint(CGPoint(x: 150, y: 240))
        CGContextAddPath(ctx, path.CGPath)
        CGContextSetLineWidth(ctx, 5)
        UIColor.greenColor().set()
        CGContextStrokePath(ctx)
    }

    
    // MARK: - path 做法一：A线 修改的path的上下文描述会强加到 B线
    func pathUseToDo(){
        // 第一条
        var path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 50, y: 125))
        path.addLineToPoint(CGPoint(x: 240, y: 125))
        path.lineWidth = 10
        UIColor.redColor().set()
        path.stroke()
        
        // 第二条
        path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 150, y: 50))
        path.addLineToPoint(CGPoint(x: 150, y: 240))
        path.stroke()

    }

}
