//
//  ZPPMessageItemController.swift
//  WeChatUI
//
//  Created by 鹏 朱 on 15/10/24.
//  Copyright © 2015年 鹏 朱. All rights reserved.
//

import UIKit

class ZPPMessageItemController: UIViewController {
    
    @IBOutlet var avatar : UIImageView!
    @IBOutlet var msgBackground : UIControl!
    @IBOutlet var msgLabel : UILabel!
    @IBOutlet var msgLabelHeight: NSLayoutConstraint!
    @IBOutlet var msgLabelWidth: NSLayoutConstraint!
    var msgItemY: NSLayoutConstraint!
    
    //var msgString:NSString = ""
    weak var msgItemModel:ZPPMessageItemModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func boundingLabelRectWithMaxWidth(maxWidth:CGFloat, maxHeight:CGFloat)->CGRect
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let attributes = [NSFontAttributeName:self.msgLabel.font, NSParagraphStyleAttributeName:paragraphStyle]
        //return self.msgString.boundingRectWithSize(CGSize(width: maxWidth, height: maxHeight), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return self.msgItemModel.msgString.boundingRectWithSize(CGSize(width: maxWidth, height: maxHeight), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
    }
    
    func loadWithMessageItemModel()
    {
        self.avatar.image = UIImage(named: msgItemModel.avatarName)
        self.msgLabel.text = msgItemModel.msgString
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
