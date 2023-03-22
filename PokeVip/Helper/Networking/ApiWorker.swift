//
//  ApiWorker.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import Foundation
import Alamofire

public protocol CoreApiControlOutput: AnyObject {
    func accessUnautorized()
}

struct ApiErrorOutput: Decodable {
    let timestamp: String
    let errors: [ApiError]
}

struct ApiError: Decodable {
    let origin: String
    let errorCode: String
    let message: String
}

let coreSemaphore = DispatchSemaphore(value: 1)
let dispatchQueue = DispatchQueue(label: "core.request.object")
final public class ApiWorker: ApiProtocol {
    
    public init() { }
    
    public static let shared = ApiWorker()
    public var controlOutput: CoreApiControlOutput?
    static var pendingRequests: [() -> Void] = []
    static var isRefreshing = false
    
    enum HttpStatusCode: Int {
        case unauthorized = 401
        case forbidden = 403
        case refusedWithMsg = 422
    }
    
    public func requestObject<T>(
        endpoint: String,
        method: HttpMethod,
        headers: HttpHeaders?,
        type: T.Type,
        encoder: Encoder,
        completion: @escaping CompletionCallback<T>) where T: Decodable {
            let headers = HTTPHeaders(headers ?? [:])
            let url = BaseUrl.baseUrl + endpoint
            
            var resultHeader = headers
            let request: () -> Void = {
                dispatchQueue.async {
                    coreSemaphore.wait()
                    AF.request(
                        url,
                        method: method.value,
                        headers: resultHeader
                    ) {
                        $0.timeoutInterval = 300
                    }.response { response in
                        coreSemaphore.signal()
                        self.resolveResponse(response: response, type: type, completion: completion)
                    }
                }
            }
            request()
    }
    
}

extension ApiWorker {
    private func resolveResponse<T>(response: AFDataResponse<Data?>,
                                    type: T.Type,
                                    completion: @escaping CompletionCallback<T>) where T: Decodable {
        guard let statusCode = response.response?.statusCode else {
            return completion(.failure(.generic))
        }
        switch statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            guard let data = response.data else {
                do {
                    guard let data = "{}".data(using: .utf8) else {
                        completion(.failure(.invalidData))
                        return
                    }
                    let dataType = try decoder.decode(type.self, from: data)
                    completion(.success(dataType))
                } catch {
                    completion(.failure(.decodingFailed))
                }
                return
            }
            do {
                let dataType = try decoder.decode(type.self, from: data)
                completion(.success(dataType))
            } catch {
                completion(.failure(.decodingFailed))
            }
        case HttpStatusCode.refusedWithMsg.rawValue, HttpStatusCode.forbidden.rawValue:
            guard let data = response.data else {
                completion(.failure(.invalidData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let dataType = try decoder.decode(ApiErrorOutput.self, from: data)
                let error = dataType.errors[0]
                completion(.failure(.apiRefuseWithMsg(message: error.message, errorCode: error.errorCode)))
                
            } catch {
                completion(.failure(.decodingFailed))
            }
        default:
            completion(.failure(.generic))
        }
    }
}
