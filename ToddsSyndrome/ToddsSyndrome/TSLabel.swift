//
//  TSLabel.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit

class TSLabel: UILabel {
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = UIColor.grayColor()
        self.numberOfLines = 0
        self.lineBreakMode = .ByWordWrapping
    }
    
    
    func setHeader(){
    self.font = UIFont.boldSystemFontOfSize(16)
    }

    func setNormal(){
    self.font = UIFont.systemFontOfSize(14)
    }
    
    func setSub(){
    self.font = UIFont.systemFontOfSize(12)
    }
}
