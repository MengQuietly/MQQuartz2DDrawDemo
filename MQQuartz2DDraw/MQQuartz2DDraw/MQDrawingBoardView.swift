//
//  MQDrawingBoardView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/15.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 画板View */
class MQDrawingBoardView: UIView {
    
    var pathColor = UIColor()
    var pathWidth = CGFloat()
    var path:MQBezierPath!
    var pathArr = [AnyObject]()
    var drawImg:UIImage?{
        didSet {
            pathArr.append(drawImg!)
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        self.addGestureRecognizer(pan)
        pathColor = UIColor.blackColor()
        pathWidth = 1
    }
    
    func panClick(pan:UIPanGestureRecognizer) {
        
        let currentP = pan.locationInView(self)
        if pan.state == UIGestureRecognizerState.Began {
            path = MQBezierPath()
            path.pathColor = pathColor
            path.lineWidth = pathWidth
            path.moveToPoint(currentP)
            pathArr.append(path)
        }
        path.addLineToPoint(currentP)
        setNeedsDisplay()
    }

    override func drawRect(rect: CGRect) {
        if pathArr.count == 0 { return }
        
        for pp in pathArr {
            if pp.isKindOfClass(UIImage) {
                
                let image = pp as! UIImage
                image.drawInRect(rect)
            }else{
                pp.pathColor.set()
                pp.stroke()
            }
        }
    }

    /// 清屏
    func clear() {
        if pathArr.count == 0 { return }
        
        pathArr.removeAll()
        setNeedsDisplay()
    }
    
    /// 撤销
    func undo() {
        if pathArr.count == 0 { return }
        
        pathArr.removeLast()
        setNeedsDisplay()
    }
}
