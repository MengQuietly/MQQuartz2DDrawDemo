//
//  MQRectUseView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/5.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 10.矩阵操作(CGContextTranslateCTM:平移；CGContextScaleCTM：缩放；CGContextRotateCTM：旋转）(必须放在添加路径之前) */
class MQRectUseView: UIView {

    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath(ovalInRect: CGRect(x: -100, y: -50, width: 200, height: 100))
        
        // 矩正操作：必须放在添加路径之前
        CGContextTranslateCTM(ctx, 100, 50) // 平移
        CGContextScaleCTM(ctx, 0.5, 0.5) // 缩放
        CGContextRotateCTM(ctx, CGFloat(M_PI_2)) // 旋转
        
        // 添加路径到上下文
        CGContextAddPath(ctx, path.CGPath)
        UIColor.redColor().set()
        
        CGContextFillPath(ctx)
        
    }
}
