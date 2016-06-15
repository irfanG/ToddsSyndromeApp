//
//  HomeVC.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UITableViewController, UITextFieldDelegate {

    weak var AddAlertSaveAction: UIAlertAction?
    var resultsArray : [Tests]?
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let reuseIdentifierForCell = Constants.CellIdentifiers.kCellPatientScore
    let h = Helper()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableHeaderView = UIView()
        tableView.estimatedRowHeight = 70;
        tableView.rowHeight = UITableViewAutomaticDimension;
        registerNIB()
    }
    


    func registerNIB(){
        let cellEntry = UINib(nibName: reuseIdentifierForCell, bundle:nil)
        self.tableView.registerNib(cellEntry, forCellReuseIdentifier: reuseIdentifierForCell)
       
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.hidesBackButton = true
        fetchData()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultsArray != nil) {
            return resultsArray!.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PatientListCell = tableView.dequeueReusableCellWithIdentifier(Constants.CellIdentifiers.kCellPatientScore, forIndexPath: indexPath) as! PatientListCell
        let patient : Tests = resultsArray![indexPath.row]
        cell.patientName.text = patient.patients?.patientName
       
        cell.testTimeStamp.text = "\(NSDate(timeIntervalSinceReferenceDate: patient.testDate))"
        cell.scoreLabel.text = "\(h.calculateResult(patient))"
        return cell
    }
    

    // MARK: - IBOutlets
    @IBAction func createNewRecord(sender: UIBarButtonItem){
        var hashtagTextField: UITextField?
        let alertController = UIAlertController(title: "Create new record", message: "Enter patient name",
                                                preferredStyle: .Alert)
        
        
        alertController.addTextFieldWithConfigurationHandler { textField in
            //listen for changes
            hashtagTextField = textField
            hashtagTextField?.placeholder = "Enter patient name"
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification(_:)), name: UITextFieldTextDidChangeNotification, object: textField)
            hashtagTextField?.delegate = self
        }
        
        
        func removeTextFieldObserver() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alertController.textFields![0])
        }
        
        // Create the actions.
        let cancelAction = UIAlertAction(title: Constants.StaticTexts.kCancel, style: .Cancel) { action in
            removeTextFieldObserver()
        }
        
        
        let otherAction = UIAlertAction(title: Constants.StaticTexts.kContinue, style: .Default) { action in
            removeTextFieldObserver()
            self.createDetailsView((hashtagTextField?.text)!)
        }
        
        otherAction.enabled = false
        
        AddAlertSaveAction = otherAction
        
        alertController.addAction(cancelAction)
        alertController.addAction(otherAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //handler
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        // Enforce a minimum length of >= 2 for secure text alerts.
        AddAlertSaveAction!.enabled = (textField.text)?.characters.count >= 2
    }
    
    func createDetailsView(patientName : String){
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Controllers.kNewRecordVC) as! NewRecordVC
            vc.patientName = patientName
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func fetchData(){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName("Tests", inManagedObjectContext: self.managedObjectContext)
        let sortByDate : NSSortDescriptor = NSSortDescriptor.init(key: "testDate", ascending: false)
        
       
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = [sortByDate]
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Tests]
            
            self.resultsArray = result
            self.tableView.reloadData()
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

}
