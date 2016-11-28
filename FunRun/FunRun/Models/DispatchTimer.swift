//
//  DispatchTimer.swift
//  FunRun
//
//  Created by DINGKaile on 11/27/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation


class DispatchTimer: NSObject {
    typealias TimerHandler = (DispatchTimer) -> Void
    fileprivate var timer: DispatchSourceTimer?
    fileprivate var repeatInterval: Double = 1.0
    fileprivate var handler: (() -> Void)?
    
    init(repeatInterval: Double, block: @escaping TimerHandler) {
        self.timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main)
        self.repeatInterval = repeatInterval
        
        super.init()
        self.handler = { () -> Void in
            block(self)
        }
        self.timer?.setEventHandler(handler: self.handler)
        self.start()
    }
    
    func start() {
        let fireTime = DispatchTime.now() + 1.0
        self.timer?.scheduleRepeating(deadline: fireTime, interval: self.repeatInterval)
        self.timer?.resume()
    }
    
    func suspend() {
        self.timer?.suspend()
    }
    
    func resume() {
        self.timer?.resume()
    }
    
    func cancel() {
        self.timer?.cancel()
    }
    
    
}
