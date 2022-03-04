//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by 山崎宏哉 on 2022/03/04.
//

import SwiftUI
import XCTest
@testable import UltimatePortfolio

class ExtensionTests: XCTestCase {

    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted numbers must be ascending.")
    }

    func testSequenceKeyPathSortingCustom() {
        struct Example: Equatable {
            let value: String
        }

        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        let array = [example1, example2, example3]

        let sortedItems = array.sorted(by: \.value) {
            $0 > $1
        }

        XCTAssertEqual(sortedItems, [example3, example2, example1], "Reverse sorting should yield c, b, a.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decoded to a non-empty array.")
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(
            data,
            "The rain in Spain falls mainly on the Spaniards.",
            "The string must match the content of DecodableString.json."
        )
    }

    func testDecodingDictionary() {
        let items = ["One": 1, "Two": 2, "Three": 3]
        let bundle = Bundle(for: ExtensionTests.self)
        let dictData = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(dictData.count, 3, "There should be 3 items decoded from DecodableDictionary.json")

        for data in dictData {
            XCTAssertTrue(items.keys.contains(data.key))
            XCTAssertTrue(items.values.contains(data.value))
        }
    }

    func testBindingOnChange() {
        // Given example binding stuff.
        var onChangeFunctionRun = false

        func exampleFunctionCall() {
            onChangeFunctionRun = true
        }

        var storedValue = 1
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleFunctionCall)

        // When the binding changes.
        changedBinding.wrappedValue = 10

        // Then assert to check the value changed.
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function must be run when the binding changed.")
    }
}
