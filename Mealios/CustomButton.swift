//
//  CustomButton.swift
//  Mealios
//
//  Created by Daniel Ries on 7/28/23.
//

import SwiftUI

struct RoundedButtonViewModifier: ViewModifier {
	var bgColor: Color
	var textColor: Color
	var cornerRadius: CGFloat = 10

	func body(content: Content) -> some View {
		content
			.padding()
			.foregroundColor(textColor)
			.background(bgColor)
			.cornerRadius(cornerRadius)
	}
}

struct RoundedButtonViewModifierPreview: PreviewProvider {
	static var previews: some View {
		Button("Continue", action: {})
			.modifier(RoundedButtonViewModifier(bgColor: Color("ButtonColor"),
			                                    textColor: Color("ButtonTextColor")))
	}
}
