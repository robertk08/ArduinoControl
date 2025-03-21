//
//  ControlCommand.swift
//  Arduino Control
//
//  Created by Robert Krause on 16.03.25.
//

import Foundation

struct ControlCommand: Codable {
    var device: String
    var action: Int
    var values: [[Int]]?
   // var matrixValues: [[Bool]]?
}
