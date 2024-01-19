//
//  TestExtensions.swift
//  Mealios
//
//  Created by Daniel Ries on 1/8/24.
//

import Foundation
import XCTest

extension NSPredicate {
    static func keyPath<T, U>(
        _ keyPath: KeyPath<T, U>,
        is type: NSComparisonPredicate.Operator = .equalTo,
        value: U,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) -> NSPredicate {
        
        return NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: keyPath),
            rightExpression: NSExpression(forConstantValue: value),
            modifier: modifier,
            type: type,
            options: options
        )
    }
}

extension XCUIElementQuery {
    func matching<U>(
        attribute keyPath: KeyPath<XCUIElementAttributes, U>,
        is comparisonOperator: NSComparisonPredicate.Operator,
        value: U,
        options: NSComparisonPredicate.Options = []
    ) -> XCUIElementQuery {
        
        let predicate = NSPredicate.keyPath(
            keyPath,
            is: comparisonOperator,
            value: value,
            options: options
        )
        return matching(predicate)
    }
}
