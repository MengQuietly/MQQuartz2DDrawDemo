//
//  MQDrawController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/2.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

class MQDrawController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view = MQDrawLineView() // 1.绘制直线
        self.view = MQDrawRectView() // 2.绘制形状
        self.view = MQDrawPieView() // 4.绘制饼图
        self.view = MQDrawHistogramView() // 5.绘制柱状图
        self.view = MQDrawStringAndImageView() // 6.绘制文字／图片
        self.view = MQDrawCopyImageView(image: UIImage(named: "3")) // 7.模仿UIImageView（失败）
        self.view = MQDrawSnowflakeView() // 8.雪花飘落View（定时器）
        self.view = MQStatusStackView() // 9.上下文状态栈
        self.view = MQRectUseView() // 10.矩阵操作(平移、缩放、旋转)
        self.view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
