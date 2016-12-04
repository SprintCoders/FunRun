//
//  UIScrollView+Extra.swift
//  FunRun
//
//  Created by hideki on 11/30/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {    
    func scrollToRight(animated: Bool) {
        let rightOffset = CGPoint(x: contentSize.width - bounds.size.width, y: 0)
        setContentOffset(rightOffset, animated: animated)
    }
    
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
