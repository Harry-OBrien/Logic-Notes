//
//  EditableText.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 5/6/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI
struct EditableText: View {
	var text: String
	@State private var editableText: String
	var focused: FocusState<Bool>.Binding
	var onChanged: (String) -> Void
	
	private var isEditing: Bool {
		focused.wrappedValue
	}
	
	init(_ text: String, focused: FocusState<Bool>.Binding, onChanged: @escaping (String) -> Void) {
		self.text = text
		self.focused = focused
		self.onChanged = onChanged
		self._editableText = State<String>(initialValue: text)
	}
	
	var body: some View {
		TextField(text, text: $editableText, onEditingChanged: { began in
			self.callOnChangedIfChanged()
		})
			.focused(focused)
			.disabled(!focused.wrappedValue)
			.multilineTextAlignment(.center)
	}
	
	private func callOnChangedIfChanged() {
		if editableText != text {
			onChanged(editableText)
		}
	}
}
