//
//  Types.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import RealmSwift
import Moya

typealias VoidClosure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias StringClosure = (String) -> Void
typealias IntClosure = (Int) -> Void
typealias DoubleClosure = (Double) -> Void

typealias IntAndBoolClosure = (Int, Bool) -> Void
typealias ItemClosure = (BaseItemable) -> Void
typealias ErrorClosure = (String) -> Void
typealias MoyaResponseClosure = (Response) -> Void

typealias NetworkingParameterClosure<T> = (T) -> Void
