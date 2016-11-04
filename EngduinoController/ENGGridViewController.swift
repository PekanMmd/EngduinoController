//
//  ENGGridViewController.swift
//  EngduinoController
//
//  Created by The Steez on 13/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit

class ENGGridViewController: ENGViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	var collection : UICollectionView!
	var inEditingMode = false
	var editItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.collection = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
		self.collection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		self.collection.delegate = self
		self.collection.dataSource = self
		
		self.title = "Engduino Controller"
		self.becomeFirstResponder()
		
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
		
		editItem = UIBarButtonItem(image: UIImage(named: "cog")!.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: "toggleEditing")
		editItem.tintColor = UIColor.whiteColor()
		self.navigationItem.rightBarButtonItem = editItem
	}
	
	func setUpUI() {
		
		self.addSubview(collection, name: "collection")
		self.addConstraintAlignAllEdges(view1: self.view, view2: collection)
		
	}
	

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collection.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
		
		let item = indexPath.item + 1
		
		cell.backgroundColor = UIColor.whiteColor()
		let button = ENGButton(instruction: item, backgroundColour: "White", titleColour: "Black", title: "\(item)", target: self)
		cell.addSubview(button)
		let views = ["b" : button]
		cell.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[b]|", options: [], metrics: nil, views: views))
		cell.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[b]|", options: [], metrics: nil, views: views))
		
		button.setTitle("\(item)", forState: .Normal)
		
		cell.layer.cornerRadius = 5
		cell.clipsToBounds = true
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		return
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		let length = (self.view.frame.size.width / 5) * 0.9
		return CGSizeMake(length, length)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 5
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 255
	}
	
	func buttonPressedAction(sender: ENGButton) {
		
		if !inEditingMode {
			var val = sender.instruction
			(UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager.sendData(NSData(bytes: &val, length: 1))
		}
	}
	
	func toggleEditing() {
		self.inEditingMode = !self.inEditingMode
		editItem.tintColor = inEditingMode ? UIColor.redColor() : UIColor.whiteColor()
	}
	
	func pop() {
		(UIApplication.sharedApplication().delegate as! AppDelegate).peripheralManager.stopAdvertising()
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	
}
















