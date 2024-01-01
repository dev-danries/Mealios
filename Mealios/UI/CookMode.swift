//
//  CookMode.swift
//  Mealios
//
//  Created by Daniel Ries on 9/10/23.
//

import SwiftUI

struct CookModeView: View {
	var instructions: [RecipeInstruction]

	init(instructions: [RecipeInstruction]) {
		self.instructions = instructions
		UIApplication.shared.isIdleTimerDisabled = true
	}

	var body: some View {
		VStack {
			TabView {
				ForEach(instructions.indices, id: \.self) { indice in
					VStack(alignment: .center, spacing: 10) {
						Text("Step \(indice + 1) / \(instructions.count)")
							.font(.custom(Fonts().robotoBold, size: 18))
						Text(instructions[indice].text)
					}
				}
			}.tabViewStyle(PageTabViewStyle())
		}
	}
}
