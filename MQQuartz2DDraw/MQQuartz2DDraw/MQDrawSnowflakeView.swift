//
//  MQDrawSnowflakeView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/4.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 8.雪花飘落View（定时器－NSTimer：调度优先级低，不适用于绘图；CADisplayLink：屏幕刷新时调用，需添加到主运行循环中） */
class MQDrawSnowflakeView: UIView {
    
    var imgY:CGFloat = 0.0

    // MARK: - 纯代码开发调用
    override func layoutSubviews() {

        // 很少用于绘图，因为调度优先级较低，并不会准时调用
//        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
        // 每次屏幕刷新(屏幕刷新频率：60次／秒)时就会调用(此方法需要添加到主运行循环中)
        let link = CADisplayLink(target: self, selector: #selector(timeChange))
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
    }
    
    // MARK: - xib 开发调用
    override func awakeFromNib() {
        
    }
    
    // 不会立马调用 drawRect方法，此方法只是给当前控件天假新的标记，等下一次屏幕刷新时才会调用 drawRect 方法
    override func drawRect(rect: CGRect) {
        
        let img = UIImage(named: "sc")
        img?.drawAtPoint(CGPoint(x: 50, y: imgY))
        if imgY >= screenH {
            imgY = 0
        }
        imgY = imgY + 10
        
    }
    
    // MARK: - 时间改变时调用
    func timeChange(){
        setNeedsDisplay()
    }

}
