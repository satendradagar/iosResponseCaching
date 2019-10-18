//
//  HTTPClient.swift
//  ApiResponseCaching
//
//  Created by Satendra Singh on 16/10/19.
//  Copyright © 2019 Satendra Singh. All rights reserved.
//

import Foundation

class HTTPClient {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data?, ClientError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = HTTPClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    private var completionResult: CompletionResult?

    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask(_ request: RequestProtocol, completion: @escaping CompletionResult) {
        completionResult = completion
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: NetworkConstants.timeout)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.allHTTPHeaderFields = request.headers
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            //return error if there is any error in making request
            if let error = error {
                self.completionResult(.failure(ClientError(error.localizedDescription)))
                return
            }
            
            //check response
            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data))
                }
                
                if response.httpStatusCode == 204 {
                    self.completionResult(.success(nil))
                }
            } else {
                let commonErrorMessage = NSLocalizedString("Somthing went wrong!", comment: "")
                guard let data = data else {
                    print(commonErrorMessage)
                    self.completionResult(.failure(ClientError(commonErrorMessage)))
                    return
                }
                do {
                    let serverError = try JSONDecoder().decode(ApiError.self, from: data)
                   print(serverError.error ?? commonErrorMessage)
                    self.completionResult(.failure(ClientError(serverError.error ?? commonErrorMessage)))
                } catch {
                    print(error)
                    self.completionResult(.failure(ClientError(commonErrorMessage)))
                }
            }
        }
        
        self.task?.resume()
    }
    
    //Cancel task
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Helper Function
    private func completionResult(_ result: Result<Data?, ClientError>) {
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}
