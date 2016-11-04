//
//  ENGRootViewController.swift
//  EngduinoController
//
//  Created by The Steez on 09/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit

class ENGRootViewController: ENGViewController, UITextFieldDelegate {
	
	var pairingCode = UITextField()
	var start		= UIButton()
	
	var peripheralManager : ENGPeripheralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.peripheralManager = (UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager
		
		

        setUpNavigationBar()
		setUpUI()
    }
	
	func setUpUI() {
		
		self.title = "Engduino Controller"
		self.view.backgroundColor = UIColor.grayColor()
		
		self.pairingCode.text = "0000"
		self.pairingCode.font = UIFont.systemFontOfSize(20)
		self.pairingCode.textAlignment = .Center
		self.pairingCode.keyboardType = .NumberPad
		self.pairingCode.keyboardAppearance = .Dark
		self.pairingCode.backgroundColor = UIColor.whiteColor()
		self.pairingCode.textColor = UIColor.blueColor()
		self.pairingCode.adjustsFontSizeToFitWidth = true
		self.pairingCode.translatesAutoresizingMaskIntoConstraints = false
		self.pairingCode.layer.cornerRadius = 10
		self.pairingCode.clipsToBounds = true
		
		self.start.setTitle("Start", forState: .Normal)
		self.start.backgroundColor = UIColor.blueColor()
		self.start.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		self.start.addTarget(self, action: "begin", forControlEvents: .TouchUpInside)
		self.start.translatesAutoresizingMaskIntoConstraints = false
		self.start.layer.cornerRadius = 10
		self.start.clipsToBounds = true
		
		self.addShadowToView(view: self.pairingCode, radius: 3, xOffset: 3, yOffset: 3)
		self.addSubview(self.pairingCode, name: "pair")
		self.addShadowToView(view: self.start, radius: 3, xOffset: 3, yOffset: 3)
		self.addSubview(self.start, name: "start")
		
		self.addConstraintAlignCenterX(view1: self.view, view2: self.pairingCode)
		self.addConstraints(visualFormat: "V:|-(30)-[pair(60)]-(30)-[start(60)]", layoutFormat: [.AlignAllLeft, .AlignAllRight])
		self.addConstraints(visualFormat: "H:[pair(250)]", layoutFormat: [])
		
	}
	
	func begin() {
		self.pairingCode.resignFirstResponder()
		peripheralManager.stopAdvertising()
		if !peripheralManager.peripheralManager.isAdvertising {
			self.updatePairingCode()
			peripheralManager.startAdvertising()
		}
		performSegueWithIdentifier("segue", sender: self)
	}
	
	func stop() {
		if peripheralManager != nil {
			if peripheralManager.peripheralManager.isAdvertising {
				peripheralManager.stopAdvertising()
			}
		}
	}

	func updatePairingCode() {
		self.peripheralManager.pairingCode = self.pairingCode.text ?? "0000"
		self.pairingCode.text = self.peripheralManager.pairingCode
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if self.peripheralManager != nil {
			if self.peripheralManager.peripheralManager.isAdvertising {
				self.peripheralManager.stopAdvertising()
			}
		}
	}


}








