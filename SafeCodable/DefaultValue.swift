//
//  DefaultValue.swift
//  SafeCodable
//
//  Created by captainteemo on 2020/2/27.
//  Copyright © 2020 captainteemo. All rights reserved.
//

import Foundation

@propertyWrapper
public struct DefaultValue<Value: DefaultProvider> {
	public var wrappedValue: Value
	public init(_ wrappedValue: Value = Value.defaultValue) {
		self.wrappedValue = wrappedValue
	}
}

extension DefaultValue: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let result = try? container.decode(Value.self)
		
		self.wrappedValue = result ?? Value.defaultValue
	}
}

extension KeyedDecodingContainer {
	public func decode<Provider>(_ type: DefaultValue<Provider>.Type, forKey key: Key) throws -> DefaultValue<Provider> {
		if let value = try self.decodeIfPresent(DefaultValue<Provider>.self, forKey: key) {
			return value
		}
		return DefaultValue()
	}
}

extension KeyedEncodingContainer {
	public mutating func encode<Provider: DefaultProvider>(_ value: DefaultValue<Provider>?, forKey key: Key) throws {
		try self.encode(value?.wrappedValue ?? Provider.defaultValue, forKey: key)
	}
}
