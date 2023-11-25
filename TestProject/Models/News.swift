//
//  News.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

// FIXME: ეს სტრუქტურაც უნდა ყოფილიყო Decodable
struct News: Decodable {
    let authors: String?
    let title: String?
    let urlToImage: String?
}
