//
//  ViewController.swift
//  EngduinoController
//
//  Created by The Steez on 03/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit


class ViewController: ENGViewController {
	
	var currentColourButton : ENGButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Engduino Controller"
		self.becomeFirstResponder()
		
		var arr = [[String : String]]()
		
		let file = NSBundle.mainBundle().pathForResource("customise", ofType: "json")
		do {
			arr = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: file!)!, options: []) as! [[String : String]]
		} catch {
			
		}
		
		for var i = 0; i < arr.count; i++ {
			arr[i]["name"] = "\(i + 1)"
		}
		
		self.setUpNavigationBar()
		setUpUI()
	}
	
	override func canBecomeFirstResponder() -> Bool {
		return true
	}
	
	override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
		if motion == UIEventSubtype.MotionShake {
			var i = 255
			(UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager.sendData(NSData(bytes: &i, length: 1))
		}
	}
	
	override func setUpNavigationBar() {
		super.setUpNavigationBar()
		
		let backItem = UIBarButtonItem(image: UIImage(named: "back")?.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: "pop")
		backItem.tintColor = UIColor.whiteColor()
		self.navigationItem.backBarButtonItem = backItem
	}
	
	func setUpUI() {
		
		self.view.backgroundColor = UIColor.blackColor()
		
		currentColourButton = ENGButton(instruction: 0, backgroundColour: "Black", titleColour: "Black", title: "", target: self)
		currentColourButton.userInteractionEnabled = false
		self.addSubview(currentColourButton, name: "ccb")
		
		for var i = 65; i < 102; i++ {
			
			let button = ENGButton(instruction: i, backgroundColour: "White",titleColour: "Black", title: "", target: self)
			
			self.addSubview(button, name: "b\(i)")
			
			self.addConstraintEqualSizes(view1: currentColourButton, view2: button)
			
			switch i {
			case 65: button.backgroundColor = UIColor.cyanColor(); button.setTitle("All Off", forState: .Normal)
			case 66: button.setTitle("\(i - 66)", forState: .Normal)
			case 67: button.setTitle("\(i - 66)", forState: .Normal)
			case 68: button.setTitle("\(i - 66)", forState: .Normal)
			case 69: button.setTitle("\(i - 66)", forState: .Normal)
			case 70: button.setTitle("\(i - 66)", forState: .Normal)
			case 71: button.setTitle("\(i - 66)", forState: .Normal)
			case 72: button.setTitle("\(i - 66)", forState: .Normal)
			case 73: button.setTitle("\(i - 66)", forState: .Normal)
			case 74: button.setTitle("\(i - 66)", forState: .Normal)
			case 75: button.setTitle("\(i - 66)", forState: .Normal)
			case 76: button.setTitle("\(i - 66)", forState: .Normal)
			case 77: button.setTitle("\(i - 66)", forState: .Normal)
			case 78: button.setTitle("\(i - 66)", forState: .Normal)
			case 79: button.setTitle("\(i - 66)", forState: .Normal)
			case 80: button.setTitle("\(i - 66)", forState: .Normal)
			case 81: button.setTitle("\(i - 66)", forState: .Normal)
			case 82: button.setTitle("Set All", forState: .Normal); button.backgroundColor = UIColor.redColor()
			case 83: button.backgroundColor = UIColor.redColor()
			case 84: button.backgroundColor = UIColor.blueColor()
			case 85: button.backgroundColor = UIColor.greenColor()
			case 86: button.backgroundColor = UIColor.yellowColor()
			case 87: button.backgroundColor = UIColor.magentaColor()
			case 88: button.backgroundColor = UIColor.cyanColor()
			case 89: button.backgroundColor = UIColor.whiteColor()
			case 90: button.backgroundColor = UIColor.blackColor()
			case 91: button.backgroundColor = UIColor.blueColor(); button.setTitle("SPIN", forState: .Normal)
			case 101: button.backgroundColor = UIColor.blueColor(); button.setTitle("TRACE", forState: .Normal)
			case 93: button.backgroundColor = UIColor.blueColor(); button.setTitle("BLINK", forState: .Normal)
			case 94: button.backgroundColor = UIColor.blueColor(); button.setTitle("SNAKE", forState: .Normal)
			case 95: button.backgroundColor = UIColor.blueColor(); button.setTitle("SUSTAIN", forState: .Normal)
			case 100: button.setTitle("Rainbow", forState: .Normal); button.backgroundColor = UIColor.greenColor()
			case 97: button.setTitle("MIN", forState: .Normal); button.backgroundColor = UIColor.blackColor(); button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			case 98: button.setTitle("MID", forState: .Normal); button.backgroundColor = UIColor.blackColor(); button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			case 99: button.setTitle("MAX", forState: .Normal); button.backgroundColor = UIColor.blackColor(); button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
			default: break
			}
			
		}
		
		for var j = 0; j < 12; j++ {
			let button = ENGButton(instruction: 0, backgroundColour: "Black", titleColour: "Black", title: "", target: self)
			button.userInteractionEnabled = false
			self.addSubview(button, name: "d\(j)")
			
			self.addConstraintEqualSizes(view1: currentColourButton, view2: button)
			
		}
		
		let header = UIView()
		header.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(header, name: "h")
		header.backgroundColor = UIColor.whiteColor()
		
		let logo = UIImageView(image: UIImage(named: "icon"))
		logo.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(logo, name: "l")
		
		self.addConstraintAlignTopAndBottomEdges(view1: header, view2: logo)
		self.addConstraintAlignCenterX(view1: header, view2: logo)
		self.addConstraintWidth(view: logo, width: 50)
		self.addConstraintAlignLeftAndRightEdges(view1: self.view, view2: header)
		
		self.addConstraints(visualFormat: "H:|[b75][b74][b73][b72]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b76][d0][d1][b71]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[d10][d2][b70][d3]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b77][d4][d5][b69]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[d11][d6][b68][d7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b78][d8][d9][b67]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b79][b80][b81][b66]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b82][ccb][b100][b65]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b83][b86][b85][b88]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b84][b87][b89][b90]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b91][b101][b93][b94]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b95][b97][b98][b99]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		self.addConstraints(visualFormat: "V:|[h(50)][b75][b76][d10][b77][d11][b78][b79][b82][b83][b84][b91][b95]|", layoutFormat: [])
		
	}
	
	func buttonPressedAction(sender: ENGButton) {
		
		var val = sender.instruction
		
		switch val {
			case 83: currentColourButton.backgroundColor = UIColor.redColor()
			case 84: currentColourButton.backgroundColor = UIColor.blueColor()
			case 85: currentColourButton.backgroundColor = UIColor.greenColor()
			case 86: currentColourButton.backgroundColor = UIColor.yellowColor()
			case 87: currentColourButton.backgroundColor = UIColor.magentaColor()
			case 88: currentColourButton.backgroundColor = UIColor.cyanColor()
			case 89: currentColourButton.backgroundColor = UIColor.whiteColor()
			case 90: currentColourButton.backgroundColor = UIColor.blackColor()
			default: break
		}
		
		(UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager.sendData(NSData(bytes: &val, length: 1))
	}
	
	func pop() {
		(UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager.stopAdvertising()
		self.navigationController?.popViewControllerAnimated(true)
	}
	

}

















