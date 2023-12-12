
import Alamofire
import KRProgressHUD
import ObjectMapper
import SwiftyJSON
import UIKit
import Foundation

public typealias ResponseData = [String: Any]
public typealias ResponseArray = [Any]
public typealias FailureMessage = String
public typealias ResponseString = String
public typealias FailureCode    = String

class NetworkClient {
  
    // MARK: - Constant
    struct Constants {
      
      struct RequestHeaderKey {
        static let contentType                  = "Content-Type"
        static let applicationJSON              = "application/json"
      }
      
      struct HeaderKey {
        
        static let Authorization                = "Authorization"
      }
      
      struct ResponseCode {
        
        static let kSuccessCode                 = "OK"
        static let kAuthorization               = "E_AUTHORIZED"
      }
    }
  
    // MARK: - Properties
    
    // A Singleton instance
    static let shared = NetworkClient()
    
    // A network reachability instance
    let networkReachability = NetworkReachabilityManager()
    
    
    // MARK: - Network Request
    
    // Global function to call web service
    func request(_ url: URLConvertible, command: String, method: Alamofire.HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = ApplicationData.authorizationHeaders, success:@escaping ((Any, String)->Void), failure:@escaping ((FailureMessage,FailureCode, Any? )->Void)) {
        
        KRProgressHUD.show()
        // check network reachability
        guard (networkReachability?.isReachable)! else {

            KRProgressHUD.dismiss()
            failure(StringConstant.NoInternetConnection,"100", nil)
            return
        }
        
        var finalURL : URL?
        
        // create final url
        if command.count > 0{
            let finalURLString: String = "\(url)\(command)"
            finalURL = URL(string : finalURLString)!
        }else{
            finalURL = URL(string : url as! String)!
        }
        
        
        // parameters
        let finalParameters: Parameters = parameters ?? [:]
        
        // print request url and parameters as JSON String
        do {
            let data = try JSONSerialization.data(withJSONObject: finalParameters, options:.prettyPrinted)
            let paramString = String(data: data,encoding: String.Encoding.utf8)!
            print("URL: \(String(describing: finalURL))")
            print("HEADERS: \(headers as Any)")
            print("PARAMETERS: \(paramString)")
        }
        catch {
            print(error.localizedDescription)
        }
        
        URLCache.shared.removeAllCachedResponses()

        // Network request
        AF.request(finalURL!, method: method, parameters: parameters, encoding: method == .get ? URLEncoding.queryString : JSONEncoding.default, headers: headers?.count ?? 0 > 0 ? headers! : nil ).responseJSON { response in

            KRProgressHUD.dismiss()
            if let responseError = response.error {
                failure(responseError.localizedDescription,"", nil)
                return
            }
            
            guard let responseData = response.data else {
                failure(response.error?.localizedDescription ?? "","", nil)
                return
            }
            
            let responseObject = JSON(responseData)
            let message = responseObject.dictionaryObject?["message"] as? String ?? ""
            let messageCode = responseObject.dictionaryObject?["messageCode"] as? String ?? ""
            
            if messageCode == "ER1001" {
                failure(message,messageCode,responseObject.dictionaryObject)
                return
            }

            if let data = responseObject.dictionaryObject {
                success(data as Any, message)
                return
            }
            
            failure(message,messageCode,responseObject.dictionaryObject)
        }
    }
}
