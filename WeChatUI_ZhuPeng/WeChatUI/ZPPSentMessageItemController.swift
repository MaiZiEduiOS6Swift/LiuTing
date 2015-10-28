//
//  ZPPSentMessageItemController.swift
//  WeChatUI
//
//  Created by 鹏 朱 on 15/10/24.
//  Copyright © 2015年 鹏 朱. All rights reserved.
//

import UIKit

class ZPPSentMessageItemController: ZPPMessageItemController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let itemView = self.view.viewWithTag(2)!
        NSLayoutConstraint.activateConstraints([NSLayoutConstraint(item: itemView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.size.width)])
        

        self.loadWithMessageItemModel()
        
        // 背景图片的高度比label的高度大28，宽度差为38，用于留白
        
        let msgLabelWidthValue = UIScreen.mainScreen().bounds.size.width - 104 - 15//15是msgBackground的右边距，99是消息框宽度以及msgBackground的右边距以外的宽度，宽度分布为8－50－8－25-x-13-15
        
        
        let newLabelSize:CGRect = self.boundingLabelRectWithMaxWidth(msgLabelWidthValue, maxHeight: 5000)

        self.msgLabelWidth.constant = newLabelSize.size.width + 1
        self.msgLabelHeight.constant = newLabelSize.size.height + 1
        
        displayBackgroundImage(named: "chatfrom_bg_normal")

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func highlightMessageView(sender: AnyObject) {
        displayBackgroundImage(named: "chatfrom_bg_focused")
    }
    
    @IBAction func dehighlightMessageView(sender: AnyObject) {
        displayBackgroundImage(named: "chatfrom_bg_normal")
    }
    
    
    func displayBackgroundImage(named named:String)
    {
        let sourceImage = UIImage(named: named)!
        let msgBackgroundImage = sourceImage.resizableImageWithCapInsets(UIEdgeInsets(top: 48.0, left: 29.0, bottom: 57.0, right: 74.0))
        
        if let temp = self.msgBackground.viewWithTag(100)
        {
            let msgB:UIImageView = temp as! UIImageView
            msgB.image = msgBackgroundImage
            
        }else{
            // 背景图片的高度比label的高度大28+7，宽度差为38，用于留白
            let msgBackgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.msgLabelWidth.constant + 38, height: self.msgLabelHeight.constant + 28+4))
            msgBackgroundImageView.image = msgBackgroundImage
            msgBackgroundImageView.tag = 100
            
            //self.msgBackground.layer.contents = msgBackgroundImage.CGImage //这种方法无法控制拉伸的边缘保持不变形
            self.msgBackground.insertSubview(msgBackgroundImageView, atIndex: 0)
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
