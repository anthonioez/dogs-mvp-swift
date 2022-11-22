//
//  String.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

extension String {

    // format dog weight
    func formatWeight() -> String {
        let weight = self.replacingOccurrences(of: " ", with: "")
        if !weight.isEmpty {
            return "\(weight) kg"
        } else {
            return ""
        }
    }

    // format dog height
    func formatHeight() -> String {
        let height = self.replacingOccurrences(of: " ", with: "")
        if !height.isEmpty {
            return "\(height) cm"
        } else {
            return ""
        }
    }

}
