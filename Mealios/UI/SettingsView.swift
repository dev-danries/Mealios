//
//  SettingsView.swift
//  Mealios
//
//  Created by Daniel Ries on 9/10/23.
//

import Alamofire
import SwiftUI

struct SettingsView: View {
	@State var appInfo: AppInfo = .init(production: true, version: "", demoStatus: false, allowSignup: false)
	@State private var showingChangeServerUrlAlert = false
	let appSettings = AppSettings.shared

	func fetchAppInfo() {
		AF.request("\(appSettings.serverUrl)\(APIPaths.getAppInfo)", method: .get)
			.validate()
			.responseDecodable(of: AppInfo.self) { response in
				switch response.result {
				case let .success(appInfo):
					print(appInfo)
					self.appInfo = appInfo
				case let .failure(error):
					print(error)
				}
			}
	}

	func changeServerUrl() {
		let authHeader: HTTPHeaders = [.authorization(bearerToken: appSettings.apiToken)]
		let url = "\(appSettings.serverUrl)\(APIPaths.deleteApiToken)"
			.replacingOccurrences(of: "${TOKEN}", with: String(appSettings.apiTokenId))
		AF.request(url, method: .delete, headers: authHeader)
			.validate()
			.responseDecodable(of: TokenDeleteResponse.self) { response in
				switch response.result {
				case .success:
					clearAppSettings()
				case let .failure(error):
					print(error)
				}
			}
	}

	func clearAppSettings() {
		appSettings.serverUrl = ""
		appSettings.apiToken = ""
		appSettings.apiTokenId = -1
		appSettings.isSetup = false
	}

	var body: some View {
		ZStack {
			Color("LaunchScreenBg")
				.ignoresSafeArea(.all)
			Form {
				Section(content: {
					NavigationLink {
						LabelTextSettingsView(label: "URL", value: AppSettings.shared.serverUrl)
					} label: {
						Image(systemName: "server.rack")
						Text("URL")
					}

					NavigationLink {
						LabelTextSettingsView(label: "API Key", value: AppSettings.shared.apiToken)
					} label: {
						Image(systemName: "key")
						Text("API Key")
					}

					HStack {
						Text("Version")
						Spacer()
						Text("\(appInfo.version)")
					}
				}, header: {
					Text("Server Settings")
				})

				Section {
					HStack {
						Text("Version")
						Spacer()
						Text("\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
					}
				} header: {
					Text("App Settings")
				}

				Section {
					Button("Change Server Url", role: .destructive) {
						showingChangeServerUrlAlert = true
					}
				}
			}
		}
		.navigationTitle("Settings")
		.navigationBarTitleDisplayMode(.large)
		.onAppear {
			fetchAppInfo()
		}
		.alert(isPresented: $showingChangeServerUrlAlert) {
			Alert(
				title: Text("Are you sure you want to change the server url?"),
				message: Text("There is no undo. This will delete the token and you need to sign in again"),
				primaryButton: .destructive(Text("Confirm")) {
					changeServerUrl()
				},
				secondaryButton: .cancel()
			)
		}
	}
}

struct LabelTextSettingsView: View {
	var label: String
	var value: String

	var body: some View {
		VStack {
			Form {
				Section {
					Text(value)
						.textSelection(.enabled)
				}
			}
		}.navigationTitle(label)
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			SettingsView(appInfo: AppInfo(production: true, version: "nightly", demoStatus: false, allowSignup: true))
		}

		NavigationStack {
			LabelTextSettingsView(label: "API Key",
			                      value: "fdfdsgafbfdabadfbfab.vddsavdsabFDABFDSB FDAVDSavdsavdsavfdsabfdabfdabfdgabhsdggdvkjghqwliuwejkbfvhjqhwdjbusdiljkBVJKLsbvhjkwebVJLDKWh.e9uZAaI9v4jTBZCLGwzs625K-_pzXUYT_4m0baicTn4") // swiftlint:disable:this line_length
		}
	}
}
