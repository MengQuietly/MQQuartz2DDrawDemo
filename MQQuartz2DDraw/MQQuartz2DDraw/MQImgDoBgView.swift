//
//  MQImgDoBgView.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/19.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 编辑图片背景view */
class MQImgDoBgView: UIView, UIGestureRecognizerDelegate{
    
    var imgDoBgViewBlock:((image:UIImage)->())!
    
    // 防止图片处于编辑状态而可以绘制线条
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return imgDoWithImgView
    }
    
    lazy var imgDoWithImgView:UIImageView = {
        var imgDoWithImgViews = UIImageView(frame: self.bounds)
        imgDoWithImgViews.userInteractionEnabled = true
        self.setGestureRecognizer(imgDoWithImgViews)
        self.addSubview(imgDoWithImgViews)
        return imgDoWithImgViews
    }()

    var imgDo:UIImage!{
        didSet {
            imgDoWithImgView.image = imgDo
        }
    }
    
    /// 添加手势
    private func setGestureRecognizer(imgV:UIImageView){
        // 平移手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panClick))
        imgV.addGestureRecognizer(pan)
        
        // 缩放手势
        let scale = UIPinchGestureRecognizer(target: self, action: #selector(scaleClick))
        scale.delegate = self
        imgV.addGestureRecognizer(scale)
        
        // 旋转手势
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationClick))
        rotation.delegate = self
        imgV.addGestureRecognizer(rotation)
        
        // 长按手势
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longClick))
        imgV.addGestureRecognizer(long)

    }
    
    // 平移
    func panClick(pan:UIPanGestureRecognizer){
        let transP = pan.translationInView(imgDoWithImgView)
        imgDoWithImgView.transform = CGAffineTransformTranslate(imgDoWithImgView.transform, transP.x, transP.y)
        pan.setTranslation(CGPoint.zero, inView: imgDoWithImgView)
    }
    
    // 缩放
    func scaleClick(pinch:UIPinchGestureRecognizer){
        imgDoWithImgView.transform = CGAffineTransformScale(imgDoWithImgView.transform, pinch.scale, pinch.scale)
        pinch.scale = 1
    }

    // 旋转
    func rotationClick(rotation:UIRotationGestureRecognizer){
        
        imgDoWithImgView.transform = CGAffineTransformRotate(imgDoWithImgView.transform, rotation.rotation)
        rotation.rotation = 0
    }
    
    // 长按
    func longClick(long:UILongPressGestureRecognizer){
        if long.state == UIGestureRecognizerState.Began {
            UIView.animateWithDuration(0.25, animations: { 
                    self.imgDoWithImgView.alpha = 0
                }, completion: { (finish) in
                    UIView.animateWithDuration(0.25, animations: { 
                        self.imgDoWithImgView.alpha = 1
                        }, completion: { (finish) in
                            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
                            let ctx = UIGraphicsGetCurrentContext()
                            self.layer.renderInContext(ctx!)
                            let newImg = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            self.imgDoBgViewBlock(image: newImg)
                            self.removeFromSuperview()
                    })
            })
        }
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
