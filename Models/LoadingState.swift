//
//  LoadingState.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

enum LoadingState<Value> {
    case loading
    case failed(Error)
    case loaded(Value)
}
