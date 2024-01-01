//
//  ErrorContainer.swift
//  Mealios
//
//  Created by Daniel Ries on 7/29/23.
//

import SwiftUI

struct ErrorContainer: View {
	var text: String

	var body: some View {
		VStack {
			HStack {
				Image("ErrorIcon")
					.foregroundColor(.white)
				Text(text)
					.foregroundColor(.white)
					.font(.custom(Fonts().robotoBold, size: 18))
			}
			.frame(maxWidth: .infinity)
			.padding()
		}.background(Color("ErrorColor"))
			.cornerRadius(10)
	}
}

struct ErrorContainerPreview: PreviewProvider {
	static var previews: some View {
		ForEach(ColorScheme.allCases, id: \.self) {
			ErrorContainer(text: "Error fetching new recipes. Please try again").preferredColorScheme($0)
		}
	}
}
