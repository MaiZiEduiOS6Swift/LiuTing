//
//  ZPPChatToolBar.swift
//  WeChatUI
//
//  Created by 鹏 朱 on 15/10/26.
//  Copyright © 2015年 鹏 朱. All rights reserved.
//

import UIKit

class ZPPChatToolBar: UIToolbar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func loadUI()
    {
        setToolBarBackgroundImage()
        setTextFieldWidth()
        setVoiceButtonHighlightImage()
    }
    
    func setToolBarBackgroundImage(named named:String = "toolbar_bottom_bar")
    {
        let sourceImage = UIImage(named: named)!
        

        let toolBarBackgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            toolBarBackgroundImageView.image = sourceImage
        
        self.insertSubview(toolBarBackgroundImageView, atIndex: 1)
        
    }
    
    func setTextFieldWidth()
    {
        let items = self.items!
        items[1].width = UIScreen.mainScreen().bounds.width - 160
    }
    
    func setVoiceButtonHighlightImage()
    {
        let voiceButton = self.items![0].customView as! UIButton
        voiceButton.setImage(UIImage(named: "chat_bottom_voice_press"), forState: UIControlState.Highlighted)
    }
    
    

}
