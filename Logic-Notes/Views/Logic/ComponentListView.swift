//
//  ComponentListView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 23/06/2021.
//

import SwiftUI

struct ComponentListView: View {
	
	var body: some View {
		List {
			Section(header: Text("Logic Blocks").font(.title.bold())) {}
			
			// TODO: Make list into JSON array that is loaded in instead of individually instantiated objects
			/*
			Section(header: Text("Motion")) {
				MoveSteps(steps: 5)
				ChangeX(10)
				SetX(for: [], to: 10)
				ChangeY(10)
				SetY(for: [], to: 10)
				XPosition()
				YPosition()
			}
			
			Section(header: Text("Looks")) {
				Say("Hello world!")
				ShowBlock()
				HideBlock()
			}
			
			Section(header: Text("Sounds & Notifications")) {
				PlaySound()
			}
			
			Section(header: Text("Events")) {
				FlagPressed()
				BroadcastReceive()
				BroadcastSend()
				BroadcastSendAndWait()
			}
			
			Section(header: Text("Control")) {
				WaitSeconds(10)
				RepeatNumTimes(10)
				RepeatForever()
				IfCondition()
				IfElseCondition()
				WaitUntilCondition()
				RepeatUntilCondition()
				End()
			}
			
			Section(header: Text("Operators")) {
				Group {
					Addition()
					Subtraction()
					Multiplication()
					Division()
					Random()
				}
				Group {
					LessThan()
					MoreThan()
					EqualTo()
				}
				Group {
					BooleanAnd()
					BooleanOr()
					BooleanNot()
				}
			}
			
			Section(header: Text("Variables")) {
				
			}*/
		}
		.listSeparatorStyle(style: .none)
		.frame(maxWidth: .infinity, alignment: .top)
		.edgesIgnoringSafeArea(.all)
	}
}

struct ComponentListView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentListView()
    }
}
