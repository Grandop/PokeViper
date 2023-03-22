//
//  ApiProtocol.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import Foundation
import Alamofire

public typealias HttpHeaders = [String: String]

public enum Encoder: Int {
    case json
    case formUrl
}

public protocol ApiProtocol: AnyObject {
    func requestObject<T: Decodable>(endpoint: String,
                                     method: HttpMethod,
                                     headers: HttpHeaders?,
                                     type: T.Type,
                                     encoder: Encoder,
                                     completion: @escaping CompletionCallback<T>)

}

public enum CompletionStatus<T> {
    case success(T)
    case failure(RequestError)
}

public enum RequestError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
    case unauthorized
    case generic
    case apiRefuseWithMsg(message: String, errorCode: String)

    public var errorCode: String {
        switch self {
        case .apiRefuseWithMsg(_, let errorCode):
            return errorCode
        default:
            return ""
        }
    }
    public var message: String {
        switch self {
        case .apiRefuseWithMsg(let apiMessage, _):
            return apiMessage
        case .unauthorized:
            return "Sua sessão expirou"
        default:
            return "Ops! Algo deu errado! Já estamos tentando resolver esse problema, tente novamente mais tarde"
        }
    }
}

public enum HttpMethod {
    case post
    case get
    case put
    case patch
    case delete

    public var value: HTTPMethod {
        switch  self {
        case .post:
            return .post
        case .get:
            return .get
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}

public typealias RequestResult<T> = Result<T, RequestError>
public typealias CompletionCallback<T: Decodable> = (CompletionStatus<T>) -> Void
