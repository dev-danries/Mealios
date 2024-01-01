//
//  SetupView.swift
//  Mealios
//
//  Created by Daniel Ries on 7/28/23.
//

import Alamofire
import SwiftUI

class SetupViewModel: ObservableObject {
	@Published var serverUrl: String = ""
	@Published var username: String = ""
	@Published var password: String = ""
	@Published var hasError: Bool = false
	@Published var errMsg: String = ""
	@Published var loading: Bool = false
	@Published var loadingState: String = "Fetching User Token"

	func validateUrl(urlString: String?) -> Bool {
		let urlRegEx = "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)" // swiftlint:disable:this line_length
		return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
	}

	func validateEmailPassword() -> Bool {
		if username.isEmpty || password.isEmpty {
			return false
		}
		return true
	}

	// swiftlint:disable:next function_body_length
	func onSubmit() {
		hasError = false
		loading = true
		if !validateUrl(urlString: serverUrl) {
			hasError = true
			errMsg = "Please enter a valid url"
			loading = false
			return
		}
		if !validateEmailPassword() {
			hasError = true
			errMsg = "Please enter email or password"
			loading = false
			return
		}
		let headers: HTTPHeaders = [
			"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
		]
		AF.request(serverUrl + APIPaths.getUserToken, method: .post,
		           parameters: UserTokenRequest(username: username, password: password).getAsURLEncodedFormParams(),
		           encoding: URLEncoding.httpBody,
		           headers: headers)
			.validate()
			.responseDecodable(of: UserTokenResponse.self) { response in
				switch response.result {
				case let .success(userTokenResponse):
					self.loadingState = "Creating API Token"
					print(userTokenResponse)
					let authHeader: HTTPHeaders = [.authorization(bearerToken: userTokenResponse.token)]
					AF.request(self.serverUrl + APIPaths.createApiToken, method: .post, parameters: APITokenRequest(name: "\(self.username)_Mealios API Token"), encoder: JSONParameterEncoder.default, headers: authHeader) // swiftlint:disable:this line_length
						.validate()
						.responseDecodable(of: APITokenResponse.self) { response in
							switch response.result {
							case let .success(apiTokenResponse):
								print(apiTokenResponse)
								let appSettings = AppSettings.shared
								appSettings.apiToken = apiTokenResponse.token
								appSettings.apiTokenId = apiTokenResponse.id
								appSettings.serverUrl = self.serverUrl
								appSettings.isSetup = true
								DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
									self.loading = false
								}
							case let .failure(error):
								print(error)
							}
						}

				case let .failure(error):
					print(error)
					self.hasError = true
					switch error {
					case .responseValidationFailed:
						if error.responseCode! == 401 {
							self.errMsg = "Email/Username and password combination are wrong"
						} else {
							self.errMsg = "Error reaching the Mealie server"
						}
					case .invalidURL:
						self.errMsg = "Please enter a valid URL"
					default:
						self.errMsg = "An error occured. Please try again"
					}
					self.loading = false
				}
			}
	}
}

struct SetupView: View {
	@StateObject var viewModel = SetupViewModel()

	var body: some View {
		ZStack {
			Color("LaunchScreenBg")
				.ignoresSafeArea(.all)
			VStack {
				if !viewModel.loading {
					Spacer()
						.frame(height: 80)
					Text("Welcome")
						.font(Font.custom(Fonts().robotoBold, size: 46))
						.foregroundColor(Color("LaunchScreenFont"))
					Text("To get started, enter the URL of your Mealie server")
						.multilineTextAlignment(.center)
						.font(Font.custom(Fonts().robotoRegular, size: 20))
						.foregroundColor(Color("LaunchScreenFont"))
						.padding([.bottom], 60)
					VStack(spacing: 20) {
						if viewModel.hasError {
							ErrorContainer(text: viewModel.errMsg)
						}
						TextField("Server Url", text: $viewModel.serverUrl)
							.textInputAutocapitalization(.never)
							.keyboardType(.URL)
							.textContentType(.URL)
							.modifier(RoundedInputViewModifier(color: Color("LaunchScreenFont")))
						TextField("Mealie Email", text: $viewModel.username)
							.textInputAutocapitalization(.never)
							.keyboardType(.emailAddress)
							.textContentType(.emailAddress)
							.modifier(RoundedInputViewModifier(color: Color("LaunchScreenFont")))
						SecureField("Mealie Password", text: $viewModel.password)
							.textContentType(.password)
							.modifier(RoundedInputViewModifier(color: Color("LaunchScreenFont")))
					}
					Spacer()
					Button("Continue", action: { viewModel.onSubmit() })
						.frame(maxWidth: .infinity)
						.modifier(RoundedButtonViewModifier(
							bgColor: Color("ButtonColor"),
							textColor: Color("ButtonTextColor")
						))
				} else if viewModel.loading {
					Spacer()
					VStack {
						Text(viewModel.loadingState)
							.font(Font.custom(Fonts().robotoRegular, size: 20))
							.foregroundColor(Color("LaunchScreenFont"))
						LottieView(name: "pizza", loopMode: .loop)
					}
					Spacer()
				}
			}.padding([.leading, .trailing], 30)
		}
	}
}

struct SetupView_Previews: PreviewProvider {
	static let errorViewModel: SetupViewModel = {
		var viewModel = SetupViewModel()
		viewModel.hasError = true
		viewModel.errMsg = "Incorrect username or password entered"
		return viewModel
	}()

	static let loadingViewModel: SetupViewModel = {
		var viewModel = SetupViewModel()
		viewModel.loading = true
		return viewModel
	}()

	static var previews: some View {
		ForEach(ColorScheme.allCases, id: \.self) {
			SetupView().preferredColorScheme($0).previewDisplayName("\($0)")
		}
		ForEach(ColorScheme.allCases, id: \.self) {
			SetupView(viewModel: errorViewModel).preferredColorScheme($0).previewDisplayName("Error \($0)")
		}
		ForEach(ColorScheme.allCases, id: \.self) {
			SetupView(viewModel: loadingViewModel).preferredColorScheme($0).previewDisplayName("Loading \($0)")
		}
	}
}
