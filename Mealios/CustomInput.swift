//
//  CustomInput.swift
//  Mealios
//
//  Created by Daniel Ries on 7/28/23.
//

import SwiftUI

struct RoundedInputViewModifier: ViewModifier {
	var color: Color
	var cornerRadius: CGFloat = 10

	func body(content: Content) -> some View {
		content
			.cornerRadius(cornerRadius)
			.padding()
			.foregroundColor(color)
			.overlay(RoundedRectangle(cornerRadius: cornerRadius)
				.strokeBorder(lineWidth: 2)
			)
	}
}

struct RoundedInputView_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(ColorScheme.allCases, id: \.self) {
			TextField("", text: .constant("Some Url"))
				.modifier(RoundedInputViewModifier(color: Color("LaunchScreenFont")))
				.preferredColorScheme($0)
		}
	}
}
