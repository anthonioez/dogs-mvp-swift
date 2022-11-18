//
//  String.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import Foundation

extension String {

    func formatWeight() -> String {
        let weight = self.replacingOccurrences(of: " ", with: "")
        if !weight.isEmpty {
            return "\(weight) kg"
        } else {
            return ""
        }
    }

    func formatHeight() -> String {
        let height = self.replacingOccurrences(of: " ", with: "")
        if !height.isEmpty {
            return "\(height) cm"
        } else {
            return ""
        }
    }

}
