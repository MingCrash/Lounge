//
//  NavigationViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/1.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
//        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "btn_back")
//        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "btn_back")
//        let offset = UIOffset.init(horizontal: CGFloat(FLT_MAX), vertical: CGFloat(FLT_MAX))
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(offset, for: .default)
        navigationBar.setBackgroundImage(#imageLiteral(resourceName: "naviga"), for: .default)
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}
