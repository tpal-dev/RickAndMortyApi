//
//  DataLoadingStatus.swift
//  RickAndMortyApi
//
//  Created by Tomasz Paluszkiewicz on 17/02/2024.
//

import Foundation

enum DataLoadingStatus {
    case notStarted
    case loading
    case success
    case error
    case paginationLimitReached
}
