//
//  ContentView.swift
//  Mealios
//
//  Created by Daniel Ries on 7/28/23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var appSettings: AppSettings = .shared

	var body: some View {
		if appSettings.isSetup {
			HomeView()
		} else {
			SetupView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
