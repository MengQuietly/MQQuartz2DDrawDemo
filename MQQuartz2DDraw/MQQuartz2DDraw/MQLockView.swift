//
//  MQLockView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/10.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 锁View:pan 手势监听，绘制连线，密码判断 */
class MQLockView: UIView {
    
    var currentP = CGPoint() // 当前点
    var arraySelBtn = [UIButton]() // 获取选中按钮
    var pwdStr = String()
    
    override func awakeFromNib() {
        // 添加手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        self.addGestureRecognizer(pan)
        
        // 设置按钮
        for i in 0..<9 {
            let btn = UIButton(type: UIButtonType.Custom)
            btn.tag = i
            btn.userInteractionEnabled = false
            btn.setImage(UIImage(named: "on"), forState: UIControlState.Normal)
            btn.setImage(UIImage(named: "off"), forState: UIControlState.Selected)
            self.addSubview(btn)
        }
    }
    
    func panClick(pan:UIPanGestureRecognizer){
        currentP = pan.locationInView(self)
        
        // 设置按钮选中
        for btn:UIButton in self.subviews as! [UIButton] {
            // 判断 currentP 是否在 按钮上、按钮没被选中
            if (CGRectContainsPoint(btn.frame, currentP) == true) && btn.selected != true {
                btn.selected = true
                arraySelBtn.append(btn)
            }
        }
        
        // 手指抬起，清空数组 arraySelBtn、判断密码
        if pan.state == UIGestureRecognizerState.Ended {
            // 快速遍历(OC 中使用：makeObjectPerformSelector)
            arraySelBtn.forEach({ (button) in
                pwdStr += "\(button.tag)"
                button.selected = false
            })
            
            if pwdStr == "1478" {
                print("恭喜你！！！")
            }else{
                print("pwd = \(pwdStr)，密码错误！！！")
            }
            arraySelBtn.removeAll()
            pwdStr = ""
        }
        
        setNeedsDisplay()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count
        let cloNum = 3 // 列数
        var x:CGFloat = 0
        var y:CGFloat = 0
        let wh:CGFloat = 70
        let margin = (self.bounds.size.width - CGFloat(cloNum) * wh) / (CGFloat(cloNum) + 1)
        
        var clo = 0
        var row = 0
        
        for i in 0..<count {
            let btn = self.subviews[i]
            clo = i % cloNum
            row = i / cloNum
            x = margin + CGFloat(clo) * (wh + margin)
            y = CGFloat(row) * (wh + margin)
            btn.frame = CGRect(x: x, y: y, width: wh, height: wh)
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        
        if arraySelBtn.count == 0 {return}
        for i in 0 ..< arraySelBtn.count {
            let btn = arraySelBtn[i]
            if i == 0 {
                path.moveToPoint(btn.center)
            } else {
                path.addLineToPoint(btn.center)
            }
        }
        
        path.addLineToPoint(currentP)
        
        path.lineWidth = 8
        path.lineJoinStyle = CGLineJoin.Round
        UIColor.greenColor().set()
        path.stroke()
    }

}
