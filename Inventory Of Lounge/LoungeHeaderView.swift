//
//  LoungeCellViewController.swift
//  Inventory Of Lounge
//
//  Created by 朱志明 on 2017/3/2.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

@objc protocol LoungeHeaderViewDelegate {
    
    func tapHeaderViewWith(section: Int)
    
    func deleteHeaderViewWith(section :Int)
    
    func outletInfoWith(section: Int)
    
}


class LoungeHeaderView: UITableViewHeaderFooterView{
    var delegate: AnyObject?
    var section: Int?
    
    @IBOutlet var LoungeLabel: UILabel!
    
    @IBAction func deleteLounge(_ sender: Any) {
//        if self.delegate != nil && (self.delegate?.response(LoungeHeaderViewDelegate.outletInfoWith(section as! LoungeHeaderViewDelegate))) {
//            self.delegate?.outletInfoWith(section: section!)
        }
    }
  
    
    
    
    

