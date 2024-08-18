//
//  NetworkError.swift
//  SweetFetch
//
//  Created by Paul Valdes on 8/17/24.
//

import Foundation

enum NetworkError: Error {
    case responseError(String)
    case invalidData(String)
    case invalidUrl(String)
}
