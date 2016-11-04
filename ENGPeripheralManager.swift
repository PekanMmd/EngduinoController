//
//  ENGPeripheralManager.swift
//  EngduinoController
//
//  Created by The Steez on 08/10/2015.
//  Copyright © 2015 Ovation International. All rights reserved.
//

import UIKit
import CoreBluetooth

let TRANSFER_SERVICE_UUID			= "21BC7CD1-ED51-486A-99AB-AAABBE20173F"
let TRANSFER_CHARACTERISTIC_UUID	= "C8D9436E-EDD5-4B65-B187-35D395C75DD8"
let PAIRING_CHARACTERISTIC_UUID		= "A7DA8A1C-6014-485E-B909-44D3477D930E"

class ENGPeripheralManager: NSObject, CBPeripheralManagerDelegate {
	
	var pairingCode = "0000" {
		didSet {
			
			while (pairingCode as NSString).length < 4 {
				pairingCode = pairingCode.stringByAppendingString("0")
			}
			
			while (pairingCode as NSString).length > 4 {
				pairingCode = (pairingCode as NSString).stringByReplacingCharactersInRange(NSMakeRange(4, 1), withString: "")
			}
			
			peripheralManager.updateValue(pairingCode.dataUsingEncoding(NSUTF8StringEncoding)!, forCharacteristic: pairingCharacteristic, onSubscribedCentrals: nil)
		}
	}
	
	var peripheralManager : CBPeripheralManager!
	var transferCharacteristic : CBMutableCharacteristic!
	var pairingCharacteristic : CBMutableCharacteristic!
	
	override init() {
		super.init()
		
		peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
		self.startAdvertising()
		self.stopAdvertising()
		
	}
	
	func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
		
		if peripheral.state != .PoweredOn {
			print("Unable to broadcast bluetooth")
			return
		}
		
		print("Ready to connect...")
	}
	
	func startAdvertising() {
		if !peripheralManager.isAdvertising {
			if self.transferCharacteristic == nil {
				self.transferCharacteristic = CBMutableCharacteristic(type: CBUUID(string: TRANSFER_CHARACTERISTIC_UUID), properties: [CBCharacteristicProperties.Notify], value: nil, permissions: CBAttributePermissions.Readable)
			}
			
			if self.pairingCharacteristic == nil {
				self.pairingCharacteristic = CBMutableCharacteristic(type: CBUUID(string: PAIRING_CHARACTERISTIC_UUID), properties: [CBCharacteristicProperties.Notify], value: nil, permissions: CBAttributePermissions.Readable)
			}
			
			let transferService = CBMutableService(type: CBUUID(string: TRANSFER_SERVICE_UUID), primary: true)
			transferService.characteristics = [transferCharacteristic, pairingCharacteristic]
			
			peripheralManager.addService(transferService)
			peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey :  [CBUUID(string: TRANSFER_SERVICE_UUID)]])
			print("advertising...")
		}
	}
	
	func stopAdvertising() {
		if peripheralManager.isAdvertising {
//			peripheralManager.stopAdvertising()
		}
		print("Stopped advertising")
	}
	
	func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
		
		peripheralManager.updateValue(self.pairingCode.dataUsingEncoding(NSUTF8StringEncoding)!, forCharacteristic: self.pairingCharacteristic, onSubscribedCentrals: nil)
		
		print("subscribed to a characteristic")
	}
	
	
	func sendData(data: NSData) {
		
		print("attempting to send data \(data)")
		
		var didSend = true
		
		if peripheralManager != nil {
			didSend = peripheralManager.updateValue(data, forCharacteristic: transferCharacteristic, onSubscribedCentrals: nil)
		}
		
		if !didSend {
			print("failed to send")
		} else {
			print("sent")
		}
		
	}
	
	
}
