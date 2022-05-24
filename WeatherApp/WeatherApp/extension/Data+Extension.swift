//
//  Data+Extension.swift
//  WeatherApp
//
//  Created by user214203 on 5/24/22.
//

import Foundation

extension Date {
    func get(_ type: Calendar.Component)-> Int {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return Int(t < 10 ? "0\(t)" : t.description) ?? 0
    }
}
