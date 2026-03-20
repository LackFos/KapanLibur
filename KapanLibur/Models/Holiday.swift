//
//  Holiday.swift
//  KapanLibur
//
//  Created by Elvis on 19/03/26.
//

struct Holiday: Codable, Equatable {
    let name: String
    let date: String
    let day: String
    let days_until: Int
    let is_joint: Bool
    let is_today: Bool
}
