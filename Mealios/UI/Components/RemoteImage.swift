//
//  RemoteImage.swift
//  Mealios
//
//  Created by Daniel Ries on 7/30/23.
//

import SwiftUI

struct RemoteImage: View {
	private enum LoadState {
		case loading, success, failure
	}

	private class Loader: ObservableObject {
		var data = Data()
		var state = LoadState.loading

		init(url: String) {
			guard let parsedURL = URL(string: url)
			else {
				fatalError("Invalid URL: \(url)")
			}
			let sessionConfiguration = URLSessionConfiguration.default // 5

			sessionConfiguration.httpAdditionalHeaders = [
				"Authorization": "Bearer \(AppSettings.shared.apiToken)",
			]
			let session = URLSession(configuration: sessionConfiguration)
			session.dataTask(with: parsedURL) { data, _, _ in
				if let data = data, data.count > 0 {
					self.data = data
					self.state = .success
				} else {
					self.state = .failure
				}

				DispatchQueue.main.async {
					self.objectWillChange.send()
				}
			}.resume()
		}
	}

	@StateObject private var loader: Loader
	var loading: Image
	var failure: Image

	var body: some View {
		selectImage()
			.resizable()
		//            .scaledToFill()
		//            .clipped()
	}

	init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image("MealieIcon")) {
		_loader = StateObject(wrappedValue: Loader(url: url))
		self.loading = loading
		self.failure = failure
	}

	private func selectImage() -> Image {
		switch loader.state {
		case .loading:
			return loading
		case .failure:
			return failure
		default:
			if let image = UIImage(data: loader.data) {
				return Image(uiImage: image)
			} else {
				return failure
			}
		}
	}
}

struct RemoteImagePreview: PreviewProvider {
	static var previews: some View {
		RemoteImage(url: "https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg") // swiftlint:disable:this line_length
			.scaledToFill()
			.frame(height: 130)
			.clipped()
			.cornerRadius(20)
	}
}
