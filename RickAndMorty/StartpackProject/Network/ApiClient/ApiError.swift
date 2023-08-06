//
//  ApiError.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

enum ApiError: Error, LocalizedError {
    case requestIncorrect
    case unknown
    case apiError(reason: String)
    case networkError
    case decoding
    
    var errorDescription: String {
            switch self {
            case .requestIncorrect:
                return "Что-то пошло не так."
            case .unknown:
                return "Неизвестная ошибка 🤷"
            case .apiError(let reason):
                return reason
            case .networkError:
                return "Проверьте соединение с интернетом и повторите попытку."
            case .decoding:
                return "Ошибка парсинга данных"
            }
        }
}
