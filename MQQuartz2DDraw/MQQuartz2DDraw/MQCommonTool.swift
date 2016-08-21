//
//  MQCommonTool.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/3.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

let screenH = UIScreen.mainScreen().bounds.height

/** 常用方法类 */
class MQCommonTool: NSObject {

    // MARK: - 随机色
    func colorRandom()-> UIColor{
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    // MARK: - 随机数组值
    func arrayRandom()->[CGFloat]{
        
        var total:CGFloat = 100
        var array = [CGFloat]()
        var temp:CGFloat = 0
        for _ in 0..<Int(arc4random_uniform(10)+1) {
            temp = CGFloat(arc4random_uniform(UInt32(total))+1)
            array.append(temp)
            // temp ＝ 总数就直接退出循环
            if temp == total {
                break
            }
            total = total - temp
        }
        if total > 0 {
            array.append(total)
        }
        
        return array
    }
    
}
