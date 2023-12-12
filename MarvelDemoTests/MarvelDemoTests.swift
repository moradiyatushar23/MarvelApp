//
//  MarvelDemoTests.swift
//  MarvelDemoTests
//
//  Created by iMac on 06/09/21.
//

import XCTest
@testable import MarvelDemo

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: HttpClient Implementation
class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }

}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}


class MarvelDemoTests: XCTestCase {
    
    var httpClient: HttpClient!
    let session = MockURLSession()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpClient = HttpClient(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_get_request_with_URL() {

        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + "0b1d907dea3ac91ff03cac7690afdbe7ab8287dae7f385204edfef87d169f1e220737b3e&hash").md5()
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(Date().timeIntervalSince1970)&apikey=e7f385204edfef87d169f1e220737b3e&hash=\(hash)") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + "0b1d907dea3ac91ff03cac7690afdbe7ab8287dae7f385204edfef87d169f1e220737b3e&hash").md5()
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(Date().timeIntervalSince1970)&apikey=e7f385204edfef87d169f1e220737b3e&hash=\(hash)") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + "0b1d907dea3ac91ff03cac7690afdbe7ab8287dae7f385204edfef87d169f1e220737b3e&hash").md5()
        
        var actualData: Data?
        httpClient.get(url: URL(string: "https://gateway.marvel.com/v1/public/comics?ts=\(Date().timeIntervalSince1970)&apikey=e7f385204edfef87d169f1e220737b3e&hash=\(hash)")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }

}
