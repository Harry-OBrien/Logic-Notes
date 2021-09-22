//
//  LogicBlockTypeID.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/09/2021.
//

import Foundation

enum LogicBlockType: String, Codable {
	//Motion
	case MoveSteps				// Not Implemented
	case ChangeX				// Not Implemented
	case SetX
	case ChangeY				// Not Implemented
	case SetY
	case XPos					// Not Implemented
	case YPos					// Not Implemented
	
	// Looks
	case Say
	case ShowBlock				// Not Implemented
	case HideBlock				// Not Implemented
	
	// Sound
	case PlaySound 				// Not Implemented
	
	// Events
	case FlagPressed
	case BroadcastReceive		// Not Implemented
	case BroadcastSend			// Not Implemented
	case BroadcastSendAndWait	// Not Implemented
	case DateTimeReached		// Not Implemented
	
	// Control
	case WaitSeconds			// Not Implemented
	case RepeatNumTimes			// Not Implemented
	case RepeatForever			// Not Implemented
	case IfCondition			// Not Implemented
	case IfElseCondition		// Not Implemented
	case WaitUntilCondition		// Not Implemented
	case RepeatUntilCondition	// Not Implemented
	case End					// Not Implemented
	
	// Operators
	case Addition				// Not Implemented
	case Subtraction			// Not Implemented
	case Multiplication			// Not Implemented
	case Division				// Not Implemented
	case Random					// Not Implemented
	case LessThan				// Not Implemented
	case MoreThan				// Not Implemented
	case EqualTo				// Not Implemented
	case BooleanAnd				// Not Implemented
	case BooleanOr				// Not Implemented
	case BooleanNot				// Not Implemented
}
