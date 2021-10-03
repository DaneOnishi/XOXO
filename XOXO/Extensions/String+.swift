//
//  String+.swift
//  XOXO
//
//  Created by Daniella Onishi on 02/10/21.
//

import Foundation

extension String {
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

