//
//  DefaultProvider.swift
//  SafeCodable
//
//  Created by captainteemo on 2020/2/27.
//  Copyright © 2020 captainteemo. All rights reserved.
//

import Foundation

public protocol DefaultProvider: Codable {
	static var defaultValue: Self { get }
}
