//
//  MQDrawingBoardController.swift
//  MQQuartz2DDraw
//
//  Created by mengmeng on 16/8/15.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

/** 15.画板（基本画板小功能制作） */
class MQDrawingBoardController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    /// 画板View
    @IBOutlet weak var boardViews: MQDrawingBoardView!
   
    /// 清屏
    @IBAction func clearItemClick(sender: AnyObject) {
        boardViews.clear()
    }
    
    /// 撤销
    @IBAction func undoItemClick(sender: AnyObject) {
        boardViews.undo()
    }
    
    /// 橡皮擦
    @IBAction func eraserItemClick(sender: AnyObject) {
        boardViews.pathColor = UIColor.whiteColor()
    }
    
    /// 照片
    @IBAction func photoItemClick(sender: AnyObject) {

        // 打开系统相册
        let photoVC = UIImagePickerController()
        photoVC.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        photoVC.delegate = self
        self.presentViewController(photoVC, animated: true, completion: nil)
    }
    
    /// 图片操作（旋转／缩放）
    @IBAction func imgDoItemClick(sender: AnyObject) {
        // 打开系统相册
        let photoVC = UIImagePickerController()
        photoVC.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        photoVC.delegate = self
        self.presentViewController(photoVC, animated: true, completion: nil)
    }
    
    /// 保存
    @IBAction func saveItemClick(sender: AnyObject) {
        
        UIGraphicsBeginImageContextWithOptions(boardViews.bounds.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        boardViews.layer.renderInContext(ctx!)
        
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 保存到相册（必须是调用下面的 didFinishSavingWithError 方法，不能为自定义方法）
        UIImageWriteToSavedPhotosAlbum(newImg, self, #selector(image), nil)
    }
    
    // 保存到相册 回调方法
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject){
        
        var msg = String()
        if didFinishSavingWithError != nil {
            msg = "保存失败"
            return
        }
        msg = "保存成功"

        let alertVC = UIAlertController(title: "信息", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let alertViewAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) in
            print("save")
        }
        
        let cancelViewAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (UIAlertAction) in
            print("cancelViewAction")
        }
        alertVC.addAction(cancelViewAction)
        alertVC.addAction(alertViewAction)
        
        self.presentViewController(alertVC, animated: true) {}
    }

    /// 画笔选择滑板
    @IBAction func sliderClick(sender: UISlider) {
        boardViews.pathWidth = CGFloat(sender.value)
    }
    
    /// 颜色选择按钮
    @IBAction func colorBtnClick(sender: UIButton) {
        let btnColor = sender.backgroundColor!
        boardViews.pathColor = btnColor
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
//        // 照片
//        let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        boardViews.drawImg = img
//        self.dismissViewControllerAnimated(true, completion: nil)

        // 图片保存
        let img:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgV = MQImgDoBgView(frame: self.boardViews.bounds)
        self.boardViews.addSubview(imgV)
        imgV.imgDo = img

        imgV.imgDoBgViewBlock = { (img:UIImage) in
            self.boardViews.drawImg = img
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
