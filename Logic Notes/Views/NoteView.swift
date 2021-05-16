//
//  NoteView.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 15/05/2021.
//

import SwiftUI
import Foundation

struct NoteView: View {
	
	var content: String
	
	var body: some View {
		Text(content)
			.font(.custom("BradleyHandITCTT-Bold", size: 23))
			.frame(width: 120, height: 120, alignment: .center)
			.background(Color(red: 253/255, green: 224/255, blue: 45/255))
			.border(Color(red: 243/255, green: 216/255, blue: 46/255), width: 1.5)
	}
}
