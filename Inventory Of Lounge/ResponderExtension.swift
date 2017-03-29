//
//  ResponderExtension.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/21.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit

private var currentFirstResponder: AnyObject?

extension UIResponder {
    
    func catchCurrentFirstResponder() -> AnyObject {
        currentFirstResponder = nil
        
        //这个方法只要给target设置为nil，就会遍历响应链找到第一响应者（当前响应者）
        UIApplication.shared.sendAction(#selector(wty_findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return currentFirstResponder!
    }
    
    func wty_findFirstResponder(_ sender: AnyObject) {
        // 第一响应者会响应这个方法，并且将静态变量wty_currentFirstResponder设置为自己
        currentFirstResponder = self
    }
}
