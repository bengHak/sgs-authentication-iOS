//
//  API.swift
//  Personal-project
//
//  Created by bhakko-MN on 2021/12/17.
//

import Foundation
import Alamofire

enum API {
    // auth
    case requestSignin
    case requestSignup
    case verifyEmail(email: String)
    case verifyCode(email: String, code: String)
    
    // user
    case requestMyProfile
    case requestProfileById(userId: Int)
    case requestUpdateProfile
    
    // admin
    case requestUserList
    case requestDeleteUser(userId: Int)
    case requestUpdateUserProfile(userId: Int)
    case requestUpdateUserAuthority(userId: Int)
    
    // mail
    case requestCodeMail(email: String)
}

extension API {
    /// base url
    var baseUrl: String {
        "http://localhost:8080/api"
    }
    
    /// api url path
    var path: String {
        switch self {
        case .requestSignin:
            return "\(self.baseUrl)/auth/signin"
        case .requestSignup:
            return "\(self.baseUrl)/auth/signup"
        case .verifyEmail(_):
            return "\(self.baseUrl)/auth/verify/email"
        case .verifyCode(_, _):
            return "\(self.baseUrl)/auth/verify/code"
        case .requestMyProfile, .requestUpdateProfile:
            return "\(self.baseUrl)/user/me/profile"
        case .requestProfileById(let userId):
            return "\(self.baseUrl)/user/\(userId)/profile"
        case .requestUserList:
            return "\(self.baseUrl)/admin/user-list"
        case .requestDeleteUser(let userId), .requestUpdateUserProfile(let userId):
            return "\(self.baseUrl)/admin/\(userId)"
        case .requestUpdateUserAuthority(let userId):
            return "\(self.baseUrl)/admin/\(userId)/admin"
        case .requestCodeMail(_):
            return "\(self.baseUrl)/mail/send/code"
        }
    }
    
    /// api method
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .requestSignin:
            return .post
        case .requestSignup:
            return .post
        case .verifyEmail:
            return .post
        case .verifyCode:
            return .post
        case .requestMyProfile:
            return .get
        case .requestProfileById:
            return .get
        case .requestUpdateProfile:
            return .post
        case .requestUserList:
            return .get
        case .requestDeleteUser:
            return .delete
        case .requestUpdateUserProfile:
            return .put
        case .requestUpdateUserAuthority:
            return .put
        case .requestCodeMail:
            return .post
        }
    }
}
