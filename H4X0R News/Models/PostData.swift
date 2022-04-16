//
//  PostData.swift
//  H4X0R News
//
//  Created by Haven on 2022-04-16.
//

import Foundation

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

struct Results: Decodable {
    let hits: [Post]
}
