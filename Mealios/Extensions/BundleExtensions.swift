//
//  BundleExtensions.swift
//  Mealios
//
//  Created by Daniel Ries on 9/10/23.
//

import Foundation

public extension Bundle {
	var appName: String { getInfo("CFBundleName") }
	var displayName: String { getInfo("CFBundleDisplayName") }
	var language: String { getInfo("CFBundleDevelopmentRegion") }
	var identifier: String { getInfo("CFBundleIdentifier") }
	var copyright: String { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }

	var appBuild: String { getInfo("CFBundleVersion") }
	var appVersionLong: String { getInfo("CFBundleShortVersionString") }
	// public var appVersionShort: String { getInfo("CFBundleShortVersion") }

	fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
