//
//  PatientScoreCell.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit

class PatientListCell: UITableViewCell {

  
    
    @IBOutlet weak var patientName: TSLabel!
    @IBOutlet weak var testTimeStamp: TSLabel!
    @IBOutlet weak var scoreLabel: TSLabel!
 
    override func layoutSubviews() {
        super.layoutSubviews()
        scoreLabel.setSub()
        patientName.setNormal()
        testTimeStamp.setSub()
    }
}
