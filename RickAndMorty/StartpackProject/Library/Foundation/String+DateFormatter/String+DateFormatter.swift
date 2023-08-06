//
//  String+DateFormatter.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 27.07.2023.
//

import Foundation

extension String {
    func dateEpisode() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        dateFormatter.dateStyle = .short
        let resultString = dateFormatter.string(from: date)
        return resultString
    }
}
