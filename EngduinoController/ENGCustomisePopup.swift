//
//  ENGCustomisePopup.swift
//  EngduinoController
//
//  Created by The Steez on 16/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit

protocol customisePopupDelegate {
	
	func popupDidClose(popup : ENGCustomisePopup)
	
}

class ENGCustomisePopup: UIView {

    var button   = ENGButton()
	var delegate : customisePopupDelegate!
	
	var buttonBackgroungColour = ENGColour()
	var buttonFontColour = ENGColour()
	var buttonName = ""
	
	init(buttonIndex: Int) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.button = ENGButton.buttonWithIndex(buttonIndex, target: self)
		
		self.buttonBackgroungColour = button.colour
		self.buttonFontColour = button.fontColour
		self.buttonName = (button.titleLabel?.text)!
		
		
		
		let saveButton = UIButton()
		saveButton.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
		saveButton.translatesAutoresizingMaskIntoConstraints = false

	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	func save() {
		self.button.saveCustomisation()
		self.delegate.popupDidClose(self)
	}

}
