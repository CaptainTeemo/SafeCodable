//
//  SafeCodableTests.swift
//  SafeCodableTests
//
//  Created by captainteemo on 2020/2/27.
//  Copyright © 2020 captainteemo. All rights reserved.
//

import XCTest
@testable import SafeCodable

class SafeCodableTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		let rawString = "{\"name\": null, \"age\": 18}"
		if let data = rawString.data(using: .utf8) {
			do {
				let user = try JSONDecoder().decode(User.self, from: data)
				print(user.name)
				print(user.age)
				print(user.tags)
			} catch {
				print(error)
			}
		}
    }
}

extension String: DefaultProvider {
	public static var defaultValue: String { return "" }
}

extension Int: DefaultProvider {
	public static var defaultValue: Int { return 0 }
}

extension Double: DefaultProvider {
	public static var defaultValue: Double { return 0.0 }
}

extension Array: DefaultProvider where Element: Codable {
	public static var defaultValue: Array<Element> { return [] }
}

extension Dictionary: DefaultProvider where Key: Codable, Value: Codable {
	public static var defaultValue: Dictionary<Key, Value> { return [:] }
}

struct User: Codable {
	@DefaultValue
	var name: String
	
	@DefaultValue
	var tags: [String]
	
	@DefaultValue
	var age: Int
}
