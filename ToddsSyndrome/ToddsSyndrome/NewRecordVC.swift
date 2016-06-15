//
//  NewRecordVC.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 15/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit
import CoreData

class NewRecordVC: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var toolbar: UIToolbar!
    var birthdayTextField : UITextField?
    var newRecord : Tests?
    var newPatient: Patients?
    var patientName : String!
    var score : Double?
    let reuseIdentifierForEntryCell = Constants.CellIdentifiers.kCellRecordScore
    let reuseIdentifierForScoreCell = Constants.CellIdentifiers.kCellProgressBar
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        registerNIB()
    }
    
    func registerNIB(){
        let cellEntry = UINib(nibName: reuseIdentifierForEntryCell, bundle:nil)
        self.tableView.registerNib(cellEntry, forCellReuseIdentifier: reuseIdentifierForEntryCell)
        let cellResult = UINib(nibName: reuseIdentifierForScoreCell, bundle:nil)
        self.tableView.registerNib(cellResult, forCellReuseIdentifier: reuseIdentifierForScoreCell)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.hidesBackButton = false
        
    }
    
    override   func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Create Entity
        let tests = NSEntityDescription.entityForName("Tests", inManagedObjectContext: self.managedObjectContext)
        let patients = NSEntityDescription.entityForName("Patients", inManagedObjectContext: self.managedObjectContext)
        // Initialize Record
        newRecord = Tests(entity: tests!, insertIntoManagedObjectContext: self.managedObjectContext)
        newRecord?.hasMigrene = false
        newRecord?.usesDrugs = false
        newRecord?.gender = Constants.StaticTexts.kMale
        newPatient = Patients(entity: patients!, insertIntoManagedObjectContext: self.managedObjectContext)
        newPatient?.patientName = patientName
    }
    
    func showAlert(text: String){
        let alert = UIAlertController(title: "Validation error", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
       func saveData(){
        do {
            try self.managedObjectContext.save()
            let h = Helper()
            score =  h.calculateResult(newRecord!)
            tableView.reloadData()
        } catch {
            showAlert(Constants.ErrorMessages.kErrorSavingData)
            abort()
        }
    }
}
//MARK: Table view datasource
extension NewRecordVC {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(score == nil){
            return 1
        }
        else{
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = NewRecordSetions(rawValue: section) else { fatalError(NewRecordSetions.errorMessage) }
        switch section {
        case .Entry:
            return 5
        case .Score:
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        
        guard let section = NewRecordSetions(rawValue: indexPath.section) else { fatalError(NewRecordSetions.errorMessage) }
        switch section {
        case .Entry:
            let cell : RecordScoreCell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.kCellRecordScore, forIndexPath: indexPath) as! RecordScoreCell
            cell.delegate = self
            guard let row = EnterDataRows(rawValue: indexPath.row) else { fatalError(EnterDataRows.errorMessage) }
            switch row {
            case .Age:
                showUserActions(cell, hideText: false, hideSegment: true, hideButton: true)
                cell.testDescription.text = Constants.StaticTexts.kAge
                cell.testMeasureTextField.text = ("\(newRecord?.dateOfBirth)") == "nil" ? "" :  ("\(NSDate(timeIntervalSinceReferenceDate: (newRecord?.dateOfBirth)!))")
                self.birthdayTextField = cell.testMeasureTextField
                
                cell.testMeasureTextField.delegate = self
                
            case .Gender:
                showUserActions(cell, hideText: true, hideSegment: false, hideButton: true)
                cell.testDescription.text = Constants.StaticTexts.kGender
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kMale, forSegmentAtIndex: GenderSelection.Male.rawValue)
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kFemale, forSegmentAtIndex: GenderSelection.Female.rawValue)
                cell.testMeasureSegmentedControl.tag = SegmentedControlTypes.Gender.rawValue
            case .Migrene:
                showUserActions(cell, hideText: true, hideSegment: false, hideButton: true)
                cell.testDescription.text = Constants.StaticTexts.kMigrene
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kRare, forSegmentAtIndex: MigreneSelection.Rare.rawValue)
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kOften, forSegmentAtIndex: MigreneSelection.Often.rawValue)
                cell.testMeasureSegmentedControl.tag = SegmentedControlTypes.Migrene.rawValue
               
            case .Drugs:
                showUserActions(cell, hideText: true, hideSegment: false, hideButton: true)
                cell.testDescription.text = Constants.StaticTexts.kDrugs
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kNo, forSegmentAtIndex: DrugUsageSelection.No.rawValue)
                cell.testMeasureSegmentedControl.setTitle(Constants.StaticTexts.kYes, forSegmentAtIndex: DrugUsageSelection.Yes.rawValue)
                cell.testMeasureSegmentedControl.tag = SegmentedControlTypes.Drugs.rawValue
            case .Calculate:
                showUserActions(cell, hideText: true, hideSegment: true, hideButton: false)
                cell.testDescription.text = Constants.StaticTexts.kCalculate
                
               
            }
             return cell
        
        case .Score:
            let cell : ProgressBarCell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.kCellProgressBar, forIndexPath: indexPath) as! ProgressBarCell
            
            cell.explanationLabel.text = Constants.StaticTexts.kResultExplanation
            if (score) != nil {
            cell.progressBar.progress = Float(score!)
            cell.result.text = "\(score!)"
            }
            return cell
        }
    }
    
    func showUserActions(cell : RecordScoreCell,  hideText: Bool, hideSegment: Bool, hideButton: Bool){
        cell.testMeasureTextField.hidden = hideText
        cell.testMeasureSegmentedControl.hidden = hideSegment
        cell.calculateScoreButton.hidden = hideButton
    }
    
  
}
//MARK : UITable Row and Section Enumerators
enum NewRecordSetions: Int {
    case Entry = 0, Score
    static var errorMessage: String { return "Unrecognized `Section`" }
}
enum EnterDataRows: Int {
    case Age = 0, Gender, Migrene, Drugs, Calculate
    static var errorMessage: String { return "Unrecognized `Row`" }
}

//MARK : UITextField Delegate
extension NewRecordVC: UITextViewDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func pickerChange(sender: UIDatePicker) {
        let dateFormater = NSDateFormatter()
        dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormater.dateFormat = "yyyy/MM/dd"
        newRecord?.dateOfBirth = datePicker.date.timeIntervalSinceReferenceDate
        self.birthdayTextField!.text = dateFormater.stringFromDate(datePicker.date)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.inputAccessoryView = toolbar
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.inputView = self.datePicker
        textField.inputAccessoryView = toolbar
        if(textField.text?.characters.count > 0){
            let dateFormater = NSDateFormatter()
            dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormater.dateFormat = "yyyy/MM/dd"
            
            self.datePicker.date = NSDate(timeIntervalSinceReferenceDate: (newRecord?.dateOfBirth)!)
        }
    }
    
    @IBAction func doneHandler(sender: UIBarButtonItem){
        self.birthdayTextField!.resignFirstResponder()
    }
}

extension NewRecordVC : RecordScoreCellDelegate{
    func segmentedControlWasTapped(cell: RecordScoreCell, segmentedControlTag: Int) {
        switch segmentedControlTag {
        case 0:
            newRecord?.gender =  cell.testMeasureSegmentedControl.titleForSegmentAtIndex(cell.testMeasureSegmentedControl.selectedSegmentIndex)
        case 1:
            newRecord?.hasMigrene =  cell.testMeasureSegmentedControl.selectedSegmentIndex == MigreneSelection.Rare.rawValue ? false : true
        case 2:
            newRecord?.usesDrugs = cell.testMeasureSegmentedControl.selectedSegmentIndex == DrugUsageSelection.No.rawValue ? false : true
            
        default:
            return
        }
    }
    
    func buttonWasTapped(cell: RecordScoreCell) {
        if let errorMessageTests = newRecord?.validateTests() {
            showAlert(errorMessageTests)
            return
        }
        if let errorMessagePatients = newPatient?.validatePatient() {
            showAlert(errorMessagePatients)
            return
        }
        newRecord?.testDate = NSDate().timeIntervalSinceReferenceDate
        newRecord?.patients = newPatient
        
        saveData()

    }
}


