//
//  StubbedTarget.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 16.07.2023.
//

import Foundation

protocol Stubbed {
    var isStubbed: Bool { get }
}

extension Stubbed {
    static func loadJsonDataFromFile(_ path: String) -> Data? {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                return data as Data
            } catch _ {
                return nil
            }
        } else {
            return nil
        }
    }
}
