//
//  RecipeTagChip.swift
//  Mealios
//
//  Created by Daniel Ries on 9/4/23.
//

import SwiftUI
import WrappingHStack

struct RecipeTagChip: View {
	var tags: [RecipeTag]

	func chip(text: String) -> some View {
		VStack {
			Text(text)
				.foregroundColor(.white)
				.padding(.all, 8)
				.background(Color("TagChipColor"))
				.cornerRadius(25)
				.lineLimit(1)
		}
	}

	var body: some View {
		WrappingHStack(tags, id: \.self, alignment: .leading, lineSpacing: 10) { tag in
			chip(text: tag.name)
		}
//		VStack {
//			ForEach(tags, id: \.id) { tag in
//				chip(text: tag.name)
//			}
//		}
	}
}

struct RecipeTagChip_Previews: PreviewProvider {
	static var previews: some View {
		RecipeTagChip(tags: [
			RecipeTag(id: "1", name: "Healthy", slug: "healthy"),
			RecipeTag(id: "2", name: "Favs", slug: "favs"),
		])
	}
}
