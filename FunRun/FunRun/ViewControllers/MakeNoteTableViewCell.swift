//
//  MakeNoteTableViewCell.swift
//  FunRun
//
//  Created by DINGKaile on 12/3/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class MakeNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var momentsButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    
    let facebookRenderModeImg: UIImage = (UIImage(named: "facebook")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
    let momentsRenderModeImg: UIImage = (UIImage(named: "moments")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
    let twitterRenderModeImg: UIImage = (UIImage(named: "twitter")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
    let weiboRenderModeImg: UIImage = (UIImage(named: "weibo")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.facebookButton.alpha = 0.4
        self.facebookButton.setImage(facebookRenderModeImg, for: UIControlState.normal)
        self.facebookButton.addTarget(self, action: #selector(tapFacebookButton), for: UIControlEvents.touchUpInside)
        self.momentsButton.alpha = 0.4
        self.momentsButton.setImage(momentsRenderModeImg, for: UIControlState.normal)
        self.momentsButton.addTarget(self, action: #selector(tapMomentsButton), for: UIControlEvents.touchUpInside)
        self.twitterButton.alpha = 0.4
        self.twitterButton.setImage(twitterRenderModeImg, for: UIControlState.normal)
        self.twitterButton.addTarget(self, action: #selector(tapTwitterButton), for: UIControlEvents.touchUpInside)
        self.weiboButton.alpha = 0.4
        self.weiboButton.setImage(weiboRenderModeImg, for: UIControlState.normal)
        self.weiboButton.addTarget(self, action: #selector(tapWeiboButton), for: UIControlEvents.touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tapFacebookButton() {
        if self.facebookButton.alpha < 1.0 {
            self.facebookButton.alpha = 1.0
            self.facebookButton.setImage(UIImage(named: "facebook")!, for: UIControlState.normal)
        } else {
            self.facebookButton.alpha = 0.4
            self.facebookButton.setImage(facebookRenderModeImg, for: UIControlState.normal)
        }
        
    }
    
    func tapMomentsButton() {
        if self.momentsButton.alpha < 1.0 {
            self.momentsButton.alpha = 1.0
            self.momentsButton.setImage(UIImage(named: "moments")!, for: UIControlState.normal)
        } else {
            self.momentsButton.alpha = 0.4
            self.momentsButton.setImage(momentsRenderModeImg, for: UIControlState.normal)
        }
        
    }
    
    func tapTwitterButton() {
        if self.twitterButton.alpha < 1.0 {
            self.twitterButton.alpha = 1.0
            self.twitterButton.setImage(UIImage(named: "twitter")!, for: UIControlState.normal)
        } else {
            self.twitterButton.alpha = 0.4
            self.twitterButton.setImage(twitterRenderModeImg, for: UIControlState.normal)
        }
        
    }
    
    func tapWeiboButton() {
        if self.weiboButton.alpha < 1.0 {
            self.weiboButton.alpha = 1.0
            self.weiboButton.setImage(UIImage(named: "weibo")!, for: UIControlState.normal)
        } else {
            self.weiboButton.alpha = 0.4
            self.weiboButton.setImage(weiboRenderModeImg, for: UIControlState.normal)
        }
        
    }

}
