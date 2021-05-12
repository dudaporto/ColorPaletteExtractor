//
//  ImaggaApiClient.swift
//  ColorPaletteExtractor
//
//  Created by Maria Porto on 11/05/21.
//

import Foundation
import Alamofire

struct ImaggaApiClient {
    static let shared = ImaggaApiClient()
    private let session: Session
    
    private init() {
        session = Session()
    }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        shared.session.request(urlRequest).validate().authenticateWithImaggaCredentials()
    }
    
    func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        urlRequest: URLRequestConvertible
    ) -> UploadRequest {
        shared.session.upload(multipartFormData: multipartFormData, with: urlRequest)
            .authenticateWithImaggaCredentials()
    }
}

extension Request {
    func authenticateWithImaggaCredentials() -> Self {
        self.authenticate(
            username: ImaggaApiCredentials.key,
            password: ImaggaApiCredentials.secret
        )
    }
}
