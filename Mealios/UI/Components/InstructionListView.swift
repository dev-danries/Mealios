//
//  InstructionListView.swift
//  Mealios
//
//  Created by Daniel Ries on 9/9/23.
//

import SwiftUI

struct InstructionListView: View {
	var instructionIndex: Int
	var instruction: RecipeInstruction

	var body: some View {
		VStack(alignment: .leading) {
			if instruction.title != nil && !instruction.title!.isEmpty {
				Text(instruction.title!)
					.font(.custom(Fonts().robotoRegular, size: 15))
				Divider()
					.overlay(Color("CardColor"))
			}
			if !instruction.text.isEmpty {
				HStack(alignment: .top) {
					Text("\(instructionIndex).")
						.font(.custom(Fonts().robotoRegular, size: 14))
					Text(instruction.text)
						.font(.custom(Fonts().robotoRegular, size: 14))
				}
			}
		}
	}
}

struct InstructionListPreview: PreviewProvider {
	static var previews: some View {
		InstructionListView(instructionIndex: 1, instruction:
			RecipeInstruction(id: "",
			                  title: "Steak Preperation",
			                  text: "Meanwhile, heat a large skillet over high heat. Pat the steak dry and season all over with 2 teaspoons salt.", // swiftlint:disable:this line_length
			                  ingredientReferences: []))
			.padding([.leading, .trailing])
	}
}
