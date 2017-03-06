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
    var section: Int?          //the section of header
    
    @IBOutlet var LoungeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(colorLiteralRed: 40/255.0, green: 102/255.0, blue: 101/255.0, alpha: 1.0)
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSelf))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapSelf() {
        if (self.delegate != nil) && (self.delegate?.responds(to: #selector(LoungeHeaderViewDelegate.tapHeaderViewWith(section:))))! {
            self.delegate?.tapHeaderViewWith(section: self.section!)
        }
    }
    
    @IBAction func showDetail(_ sender: Any) {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(LoungeHeaderViewDelegate.outletInfoWith(section:))))! {
            //传送section给hander方法
            self.delegate?.outletInfoWith(section: section!)
        }
    }
    
    @IBAction func deleteLounge(_ sender: Any) {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(LoungeHeaderViewDelegate.deleteHeaderViewWith(section:))))! {
            
        }
    }
}
  

    
    
    

