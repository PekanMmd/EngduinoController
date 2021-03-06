//
//  XGActivityView.swift
//  XG Tool
//
//  Created by The Steez on 06/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGActivityView: UIView {

	init() {
		super.init(frame: CGRectZero)
		
		self.alpha = 0.0
		
		self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		
		let activityView = UIActivityIndicatorView()
		self.addSubview(activityView)
		activityView.startAnimating()
		
		self.translatesAutoresizingMaskIntoConstraints = false
		activityView.translatesAutoresizingMaskIntoConstraints = false
		
		self.addConstraint(NSLayoutConstraint(item: activityView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: activityView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
		
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}

}
