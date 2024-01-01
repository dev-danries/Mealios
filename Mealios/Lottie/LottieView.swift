//
//  LottieView.swift
//  Mealios
//
//  Created by Daniel Ries on 7/29/23.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
	var name = "pizza"
	var loopMode: LottieLoopMode = .loop

	func makeUIView(context _: UIViewRepresentableContext<LottieView>) -> UIView {
		let view = UIView(frame: .zero)

		let animationView = LottieAnimationView()
		let animation = LottieAnimation.named(name)
		animationView.animation = animation
		animationView.contentMode = .scaleAspectFit
		animationView.loopMode = loopMode
		animationView.play()

		animationView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(animationView)
		NSLayoutConstraint.activate([
			animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
			animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
		])

		return view
	}

	func updateUIView(_: UIViewType, context _: Context) {}
}
