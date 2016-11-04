//
//  ENGButton.swift
//  EngduinoController
//
//  Created by The Steez on 03/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit

class ENGButton: UIButton {
	
	var dictionaryRepresentation : [String : String] {
		get {
			var dict = [String : String]()
			
			dict["back"] = self.colour.name
			dict["font"] = self.fontColour.name
			dict["name"] = self.titleLabel?.text
			
			return dict
		}
	}

	var instruction = 0
	var colour = ENGColour(name: "White") {
		didSet {
			self.backgroundColor = colour.colour
		}
	}
	var fontColour = ENGColour(name: "Black") {
		didSet {
			self.setTitleColor(fontColour.colour, forState: .Normal)
		}
	}
	
	init() {
		super.init(frame: CGRectZero)
	}
	
	init(instruction: Int, target: AnyObject) {
		super.init(frame: CGRectZero)
		
		self.instruction = instruction
		self.translatesAutoresizingMaskIntoConstraints = false
		self.clipsToBounds = true
		self.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
		self.titleLabel?.adjustsFontSizeToFitWidth = true
		self.titleLabel?.textAlignment = .Center
		
		self.addTarget(target, action: "buttonPressedAction:", forControlEvents: .TouchUpInside)
	}
	
	

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	convenience init(instruction: Int, dictionaryRepresentation: [String : String], target : AnyObject) {
		
		self.init(instruction: instruction, backgroundColour : (dictionaryRepresentation["back"]!),  titleColour : (dictionaryRepresentation["font"]!), title : (dictionaryRepresentation["name"]!), target : target)
	}
	
	convenience init(instruction: Int, backgroundColour : String,  titleColour : String, title : String, target : AnyObject) {
		
		self.init(instruction: instruction, target: target)
		
		let colour = ENGColour(name: backgroundColour)
		self.backgroundColor = colour.colour
		self.colour = colour
		
		let colour2 = ENGColour(name: titleColour)
		self.setTitleColor(colour2.colour, forState: .Normal)
		self.fontColour = colour2
		
		self.setTitle(title, forState: .Normal)
		
	}
	
	func saveCustomisation() {
		
		var file = [[String : String]]()
		do {
			file = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: ENGButton.customisePath())!, options: []) as! [ [String : String] ]
		} catch {
			
		}
		
		file[self.instruction - 1] = self.dictionaryRepresentation
		
		var json = NSData()
		do {
			json = try NSJSONSerialization.dataWithJSONObject(file, options: .PrettyPrinted)
		} catch {
			return
		}
		
		json.writeToFile(ENGButton.customisePath(), atomically: true)
		
	}
	
	class func buttonWithIndex(index: Int, target: AnyObject) -> ENGButton {
		
		var file = [[String : String]]()
		do {
			file = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: ENGButton.customisePath())!, options: []) as! [ [String : String] ]
		} catch {
			
		}
		
		let dict = file[index - 1]
		
		return ENGButton(instruction: index, dictionaryRepresentation: dict, target: target)
		
	}

	class func customisePath() -> String {
//		let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//		let file = path + "/customise.json"
		
		let file = NSBundle.mainBundle().pathForResource("customise", ofType: ".json")!
		
		return file
	}
	
}























