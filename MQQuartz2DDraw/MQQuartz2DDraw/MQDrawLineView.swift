//
//  MQDrawLineView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/2.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 1.绘制直线View（绘制非曲线图形，使用 BezierPath，它封装了很多图形） */
class MQDrawLineView: UIView {

    // MARK: - 在此方法中绘制图形（因为：只有在此方法中才能获取到与View的Layer相关联的图形上下文）
    // 当此 View 要显示时就会调用drawRect 方法绘制图形
    // drawRect 方法：不能手动调用，因为图形上下文我们自己创建不了，只能由系统创建并传递给我们
    override func drawRect(rect: CGRect) {
        // 绘制图形3种方式：
        systemUseToDo() // 系统做法
//        quartz2DUseToDo() // 系统简化做法（CoreGraphics）
//        kitUseToDo() // UIKit 封装做法（贝赛尔）

//         //2条线绘制
        twoLine() // 两条线
        // 曲线绘制
        quadCurVeLine()
    }
    
    // MARK: - UIKit 封装做法（贝赛尔路径）
    func kitUseToDo(){
        // 1.创建路径
        let path = UIBezierPath()
        // 2.描述路径
        path.moveToPoint(CGPoint(x: 50, y: 50))
        path.addLineToPoint(CGPoint(x: 200, y: 200))
        // 3.绘制路径
        path.stroke()
    }
    
    // MARK: - Quartz2D CoreGraphics 系统简化做法（3步骤）
    func quartz2DUseToDo(){
        // 1.获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 2.描述路径
        CGContextMoveToPoint(ctx, 50, 50)
        CGContextAddLineToPoint(ctx, 200, 200)
        // 3.渲染上下文
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke)
    }
    
    // MARK: - 系统底层做法（4步骤）
    func systemUseToDo(){
        // 1.获取图形上下文
        let contextRef = UIGraphicsGetCurrentContext()
        // 2.创建路径（描述路径）
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 50, 50)
        CGPathAddLineToPoint(path, nil, 200, 200)
        // 3.添加路径到上下文
        CGContextAddPath(contextRef, path)
        // 4.渲染上下文
        CGContextStrokePath(contextRef)
    }
    
    // MARK: - 两条线
    func twoLine(){
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 100, 200)
        CGContextAddLineToPoint(ctx, 150, 250)
        CGContextAddLineToPoint(ctx, 150, 300) // 默认下条线起点为上条线终点
        // 设置绘图状态（一定在渲染之前）
        UIColor.redColor().setStroke() // 实线颜色
        UIColor.blueColor().setFill() // 填充线颜色
        CGContextSetLineWidth(ctx, 10) // 线宽
        CGContextSetLineCap(ctx, CGLineCap.Round) // 线尾端样式
        CGContextSetLineJoin(ctx, CGLineJoin.Round) // 线连接样式
        CGContextDrawPath(ctx, CGPathDrawingMode.FillStroke) // 填充实线
    }

    // MARK: - 曲线绘制
    func quadCurVeLine(){
        // 第一种： CG 绘制
        let ctx = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(ctx, 200, 50)
        CGContextAddQuadCurveToPoint(ctx, 300, 300, 250, 50)
        CGContextStrokePath(ctx)
        // 第二种：贝赛尔绘制
//        let path = UIBezierPath()
//        path.moveToPoint(CGPoint(x: 50, y: 50))
//        path.addQuadCurveToPoint(CGPoint(x: 250,y: 50), controlPoint: CGPoint(x: 150, y: 150))
//        path.stroke()
    }
    
}
