//
//  ViewController.swift
//  WeChatUI
//
//  Created by 鹏 朱 on 15/10/23.
//  Copyright © 2015年 鹏 朱. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var msgScrollView1: ZPPMessagesScrollView!
    @IBOutlet var chatToolBar1: ZPPChatToolBar!
    @IBOutlet var msgTextField1: UITextField!
    
    var isSent:Bool = true
    var keyboardHeight:CGFloat?
    var voiceButtonClicked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewBackground = UIImageView(frame: self.view.bounds)
        viewBackground.image = UIImage(named: "chat_bg_default")
        self.view.insertSubview(viewBackground, atIndex: 0)
        
        var temp = ZPPMessageItemModel()
        temp.isSent = true
        temp.avatarName = "icon01"
        temp.msgString = "111111111111111111111111111222222222222222222222233333333333444444444445555555555556666666666667777777777788888888889"
        msgScrollView1.appendMessageItem(msgItemModel: temp)
        
        temp = ZPPMessageItemModel()
        temp.isSent = false
        temp.avatarName = "icon02"
        temp.msgString = "HI 45666111111111111111111222222222222222222222233333333333444444444445555555555556666666666667777777777788888888889546354"
        msgScrollView1.appendMessageItem(msgItemModel: temp)
        
        /*temp = ZPPMessageItemModel()
        temp.isSent = false
        temp.avatarName = "icon02"
        temp.msgString = "HI 45666111111111111111111222222222222222222222233333333333444444444445555555555556666666666667777777777788888888889546354"
        msgScrollView1.appendMessageItem(msgItemModel: temp)
        
        
        temp = ZPPMessageItemModel()
        temp.isSent = false
        temp.avatarName = "icon02"
        temp.msgString = "HI 45666111111111111111111222222222222222222222233333333333444444444445555555555556666666666667777777777788888888889546354"
        msgScrollView1.appendMessageItem(msgItemModel: temp)
        
        
        temp = ZPPMessageItemModel()
        temp.isSent = false
        temp.avatarName = "icon02"
        temp.msgString = "HI 45666111111111111111111222222222222222222222233333333333444444444445555555555556666666666667777777777788888888889546354"
        msgScrollView1.appendMessageItem(msgItemModel: temp)
        */
        
        
        chatToolBar1.loadUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func keyboardWillShow(note: NSNotification)
    {
        let userInfo = note.userInfo!
        let keyboardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = keyboardBounds.size.height
        
        
        let animations:(()->Void) = {
            self.msgScrollView1.contentInset = UIEdgeInsets(top: deltaY, left: 0, bottom: 0, right: 0)
            self.msgScrollView1.transform = CGAffineTransformMakeTranslation(0, -deltaY)
            self.chatToolBar1.transform = CGAffineTransformMakeTranslation(0, -deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
            
        }else{
            animations()
        }
        
    }

    func keyboardWillHide(note: NSNotification)
    {
        let userInfo = note.userInfo!
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(()->Void) = {
            self.msgScrollView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.msgScrollView1.transform = CGAffineTransformIdentity
            self.chatToolBar1.transform = CGAffineTransformIdentity
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
            
            
        }else{
            animations()
        }
        
    }
    
    func handleTouches(sender: UITapGestureRecognizer)
    {
        if sender.locationInView(self.view).y < self.view.bounds.height - 297{
            msgTextField1.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if ((msgTextField1.text) != nil)
        {
            let temp = ZPPMessageItemModel()
            
            temp.msgString = msgTextField1.text
            
            if isSent == true
            {
                temp.isSent = true
                temp.avatarName = "icon01"
            }else{
                temp.isSent = false
                temp.avatarName = "icon02"
            }
            msgScrollView1.appendMessageItemToBottom(msgItemModel: temp)
            
            msgTextField1.text = ""
        }
        return false
    }
    @IBAction func voiceButtonClick(sender: UIButton) {
        
        if voiceButtonClicked == true{
            sender.setImage(UIImage(named: "chat_bottom_keyboard_nor"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "chat_bottom_keyboard_press"), forState: UIControlState.Highlighted)

            voiceButtonClicked = false
        }else{
            sender.setImage(UIImage(named: "chat_bottom_voice_nor"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "chat_bottom_voice_press"), forState: UIControlState.Highlighted)

            voiceButtonClicked = true
        }
    }
    
    @IBAction func upButtonClick(sender: UIButton) {
        if isSent == true
        {
            sender.setImage(UIImage(named: "chat_bottom_up_press"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "chat_bottom_up_nor"), forState: UIControlState.Highlighted)
            isSent = false
        }else{
            sender.setImage(UIImage(named: "chat_bottom_up_nor"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "chat_bottom_up_press"), forState: UIControlState.Highlighted)
            isSent = true
        }
    }
    
}

