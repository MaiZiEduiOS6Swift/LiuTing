//
//  ZPPMessagesScrollView.swift
//  WeChatUI
//
//  Created by 鹏 朱 on 15/10/26.
//  Copyright © 2015年 鹏 朱. All rights reserved.
//

import UIKit

class ZPPMessagesScrollView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var msgItemArray:NSMutableArray = NSMutableArray()
    
    func appendMessageItemToBottom(msgItemModel msgItemModel:ZPPMessageItemModel)
    {//添加一条并移动到底部
        self.appendMessageItem(msgItemModel: msgItemModel)
        scrollToBottom()
    }
    
    func scrollToBottom()
    {//移动到底部
        let maxHeight = self.contentSize.height
        let scrollViewHeight = self.frame.size.height
        self.contentOffset = CGPointMake(0, maxHeight - scrollViewHeight)
    }
    
    func updateScrollView()
    {//刷新所有但不移动当前的offset
        for tempView in self.subviews
        {
            tempView.removeFromSuperview()
        }
        
        var y:CGFloat = 0.0
        
        for tempItem in msgItemArray
        {
            y = addMessageItemToScrollView(msgItemModel: tempItem as! ZPPMessageItemModel, y: y)
        }
        
        self.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, y)
    }
    
    func appendMessageItem(msgItemModel msgItemModel:ZPPMessageItemModel)
    {//添加一条但不移动
        msgItemArray.addObject(msgItemModel)
        var y = self.contentSize.height
        y = addMessageItemToScrollView(msgItemModel: msgItemModel, y: y)
        self.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, y)
    }
    
    func addMessageItemToScrollView(msgItemModel msgItemModel:ZPPMessageItemModel, y:CGFloat)->CGFloat
    {
        var messageType:String!
        
        if msgItemModel.isSent == true
        {
            messageType = "SentMessageItemController"
        }else
        {
            messageType = "ReceivedMessageItemController"
        }
        
        let item1Controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(messageType) as! ZPPMessageItemController
        item1Controller.msgItemModel = msgItemModel
        msgItemModel.msgItemController = item1Controller //循环引用，注意使用合适的关键字避免内存泄漏
        
        let item1 = item1Controller.view.viewWithTag(2)!
        
        self.addSubview(item1)
        let item1Y = NSLayoutConstraint(item: item1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: y)
        item1Controller.msgItemY = item1Y
        NSLayoutConstraint.activateConstraints(
            [item1Y, NSLayoutConstraint(item: item1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)])
        
        return msgItemModel.msgItemController.msgLabelHeight.constant + 28.0 + 5.0 + y //返回值为该Item的底边缘的Y坐标
    }

}
