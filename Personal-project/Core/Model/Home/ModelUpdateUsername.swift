//
//  ModelUpdateUsername.swift
//  Personal-project
//
//  Created by bhakko-MN on 2021/12/17.
//

import Foundation

struct ModelUpdateUsernameResponse: Decodable {
    var success: Bool?
}


struct ModelAdminUpdateUsernameResponse: Decodable {
    var success: Bool?
    var msg: String?
}
