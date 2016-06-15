//
//  RecordScoreCell.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit

protocol RecordScoreCellDelegate : class {
    func segmentedControlWasTapped(cell : RecordScoreCell, segmentedControlTag: Int)
    func buttonWasTapped(cell : RecordScoreCell)
}

class RecordScoreCell: UITableViewCell {

    
    var delegate : RecordScoreCellDelegate?
    
    @IBOutlet weak var testDescription: TSLabel!
    
    @IBOutlet weak var testMeasureSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var testMeasureTextField: UITextField!
  
    @IBOutlet weak var calculateScoreButton: UIButton!
    
  
    override func layoutSubviews() {
        super.layoutSubviews()
        testMeasureSegmentedControl.selectedSegmentIndex = 0
        testMeasureSegmentedControl.addTarget( self, action: #selector(RecordScoreCell.segmentSelected(_:)), forControlEvents: UIControlEvents.ValueChanged )
        calculateScoreButton.addTarget(self, action: #selector(RecordScoreCell.tappedCalculate(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        testDescription.setSub()
        
    }
    
    func tappedCalculate(sender : UIButton){
       didTapCalculate(sender)
    }
    func segmentSelected(sender : UISegmentedControl){
        didTap(sender)
    }
    
    func didTap(sender: UISegmentedControl){
        self.delegate?.segmentedControlWasTapped(self, segmentedControlTag: sender.tag)
    }
    func didTapCalculate(sender: UIButton){
        self.delegate?.buttonWasTapped(self)
    }
}


enum GenderSelection: Int {
    case Male = 0, Female
    static var errorMessage: String { return "Unrecognized Gender" }
}

enum DrugUsageSelection : Int {
    case No = 0, Yes
    static var errorMessage: String { return "Unrecognized Drug usage" }
}

enum MigreneSelection: Int {
    case Rare = 0, Often
    static var errorMessage: String { return "Unrecognized Migrane selection" }
}

enum SegmentedControlTypes : Int{
    case Gender = 0, Migrene, Drugs
    static var errorMessage: String { return "Unrecognized Segmented control type" }

    
}
