//
//  MQDrawCopyImageView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/4.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 7.模仿UIImageView */
class MQDrawCopyImageView: UIView {
    
    var image:UIImage?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    init(image: UIImage?){
        self.image = image!
        super.init(frame: CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func drawRect(rect: CGRect) {
        self.image!.drawInRect(rect)
    }

}
