//
//  SearchItem.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import Foundation

public struct SearchItem: Codable {
    let artistName: String
    let country: String
    let releaseDate: Date
    let artworkUrl60: URL?
    let collectionCensoredName: String
}
