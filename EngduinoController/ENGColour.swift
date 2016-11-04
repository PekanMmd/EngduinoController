//
//  ENGColour.swift
//  EngduinoController
//
//  Created by The Steez on 15/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit

class ENGColour: NSObject {
	
	var name = "Red"
	var colour = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	
	override convenience init() {
		self.init(name: "White")
	}
	
	init(name: String) {
		super.init()
		
		self.name = name
		self.colour = ENGColour.colourForName(name)
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	class func colourForName(name : String) -> UIColor {
		
		var colour = UIColor.redColor()
		
		switch name {
			case "Red"		: colour = UIColor.redColor()
			case "Orange"	: colour = UIColor.orangeColor()
			case "Blue"		: colour = UIColor.blueColor()
			case "Yellow"	: colour = UIColor.yellowColor()
			case "Green"	: colour = UIColor.greenColor()
			case "Magenta"	: colour = UIColor.magentaColor()
			case "Cyan"		: colour = UIColor.cyanColor()
			case "White"	: colour = UIColor.whiteColor()
			case "Black"	: colour = UIColor.blackColor()
			case "Grey"		: colour = UIColor.grayColor()
			default			: colour = UIColor.blackColor()
		}
		
		return colour
	}
	
	class func allColours() -> [ENGColour] {
		
		var array = [ENGColour]()
		
		array.append(ENGColour(name: "Red"))
		array.append(ENGColour(name: "Orange"))
		array.append(ENGColour(name: "Yellow"))
		array.append(ENGColour(name: "Green"))
		array.append(ENGColour(name: "Cyan"))
		array.append(ENGColour(name: "Blue"))
		array.append(ENGColour(name: "Magenta"))
		array.append(ENGColour(name: "White"))
		array.append(ENGColour(name: "Grey"))
		array.append(ENGColour(name: "Black"))
		
		return array
	}
	

}







