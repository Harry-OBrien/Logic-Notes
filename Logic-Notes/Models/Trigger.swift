//
//  Trigger.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 11/06/2021.
//

import Foundation

protocol Trigger {
	func requirementsMet() -> Bool
}

struct AlwaysPositiveTrigger: Trigger {
	func requirementsMet() -> Bool {
		return true
	}
}

struct AlwaysNegativeTrigger: Trigger {
	func requirementsMet() -> Bool {
		return false
	}
}

struct TimeBasedTrigger: Trigger {
	
	let time: Date = Date(timeIntervalSinceNow: 1000)
	
	func requirementsMet() -> Bool {
		return true
	}
}
