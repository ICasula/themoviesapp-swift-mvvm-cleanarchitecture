//
//  ConnectionError.swift
//  TheMoviesApp
//
//  Created by Ignasi Casulà on 07/01/2022.
//

import Foundation

public protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
