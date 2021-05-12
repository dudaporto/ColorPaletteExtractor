//
//  ImaggaApiRouter.swift
//  ColorPaletteExtractor
//
//  Created by Maria Porto on 11/05/21.
//

import Foundation
import Alamofire

enum ImaggaApiRouter: URLRequestConvertible {
    private static let baseURLPath = "https://api.imagga.com/v2"
    
    case colors(String)
    case upload
        
    var httpMethod: HTTPMethod {
        switch self {
        case .colors(_):
            return .get
        case .upload:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .colors(_):
            return "/colors"
        case .upload:
            return "/uploads"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .colors(let imageID):
            return ["image_upload_id" : imageID, "extract_object_colors": 0]
        case .upload:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Self.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10 * 1000
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
