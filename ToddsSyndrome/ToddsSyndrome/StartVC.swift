//
//  ViewController.swift
//  ToddsSyndrome
//
//  Created by Irfan Godinjak on 14/06/16.
//  Copyright © 2016 ba.irfan. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    //properties
    @IBOutlet weak var welcomeTextLabel: TSLabel!
    @IBOutlet weak var swipeRightLabel: TSLabel!
    
    @IBOutlet weak var swipeLeftLabel: TSLabel!
    @IBOutlet weak var dontShowAgainLabel: TSLabel!
    @IBOutlet weak var dontShowAgainSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func  prepareUI(){
        //set label texts
        welcomeTextLabel.text = Constants.StaticTexts.kTextWelcome
        swipeRightLabel.text = Constants.StaticTexts.kTextSwipeRight
        
        // adding  Right Swipe gesture
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        rightSwipe.direction = .Left
        
        view.addGestureRecognizer(rightSwipe)
    }
    
    func handleSwipes(sender : UISwipeGestureRecognizer) {
         showHomeVC()
    }

    func showHomeVC(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.Controllers.kHomeVC)
        vc?.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showHelp(){
    
    }
}

