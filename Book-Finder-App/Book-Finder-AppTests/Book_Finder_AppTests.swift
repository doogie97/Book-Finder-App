//
//  Book_Finder_AppTests.swift
//  Book-Finder-AppTests
//
//  Created by 최최성균 on 2022/09/06.
//

import XCTest
@testable import Book_Finder_App

class Book_Finder_AppTests: XCTestCase {
    //MARK: - 테스트를 위한 메서드
    func dataFromJson(fileName: String) -> Data {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: fileName, ofType: "json")
        let jsonString = try? String(contentsOfFile: path ?? "")
        return jsonString?.data(using: .utf8) ?? Data()
    }
    
    //MARK: - DataDecoder 테스트
    func test_testSearchResult를_DataDecoder의_decode메서드로parsing시_0번째책의title이_안녕과일치하는지() {
        //given
        let dataDecoder = DataDecoder()
        let data = dataFromJson(fileName: "testSearchResult")
        
        //when
        guard let searchResult = try? dataDecoder.parse(data: data, resultType: SearchResult.self) else {
            //then
            XCTFail()
            return
        }
        
        let result = searchResult.items?[0].volumeInfo?.title
        
        //then
        XCTAssertEqual(result, "안녕")
    }
    
    func test_옳바르지않은data를_DataDecoder의_decode메서드로parsing시_decodeError를던지는지() {
        //given
        let dataDecoder = DataDecoder()
        let data = Data()
        
        //when
        do {
            let _ = try dataDecoder.parse(data: data, resultType: SearchResult.self)
        } catch let error{
            // then
            guard let error = error as? APIError else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, APIError.decodeError)
        }
    }
    
    //MARK: - NetworkManager 테스트
    // 테스트를 위한 메서드
    func makeDummyData(data: Data?, statusCode: Int, error: Error?) -> ResponseResult {
        let rsponse = HTTPURLResponse(url: URL(string: "test")!, statusCode: statusCode, httpVersion: "2", headerFields: nil)
        return ResponseResult(data: data, response: rsponse, error: error)
    }
    
    func test_문자열_행복_을Data로변환해_netWorkHandler의_request호출시_정상적으로가져오는지() {
        //given
        let promise = expectation(description: "convertError와 일치하는지")
        let testString = "행복"
        let dummyData = makeDummyData(data: testString.data(using: .utf8), statusCode: 200, error: nil)
        let netWorkHandler = NetworkManger(urlSession: StubURLSession(dummyData: dummyData))
        let testAPIModel = TestAPIModel(bookTitle: "", host: "", path: "", method: .get)
        //when
        netWorkHandler.request(api: testAPIModel) { data in
            switch data {
            case .success(let data):
                let string = String(data: data, encoding: .utf8)
                //then
                XCTAssertEqual(string, testString)
            case .failure(_):
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    
    func test_netWorkManger의_request호출시_url이_올바르지않을경우_convertError를_잘던지는지() {
        //given
        let promise = expectation(description: "convertError와 일치하는지")
        let dummyData = makeDummyData(data: Data(), statusCode: 200, error: nil)
        let netWorkHandler = NetworkManger(urlSession: StubURLSession(dummyData: dummyData))
        let worongString = "   "
        let testAPIModel = TestAPIModel(bookTitle: "", host: worongString, path: "", method: .get)
        //when
        netWorkHandler.request(api: testAPIModel) { data in
            switch data {
            case .success(_):
                XCTFail()
            case .failure(let error):
                //then
                XCTAssertEqual(error, APIError.urlError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_netWorkManger의_request호출시_통신과정에error가있을경우_transportError를_잘던지는지() {
        //given
        let promise = expectation(description: "transportError와 일치하는지")
        let dummyData = makeDummyData(data: Data(), statusCode: 200, error: APIError.decodeError)
        let netWorkHandler = NetworkManger(urlSession: StubURLSession(dummyData: dummyData))
        let testAPIModel = TestAPIModel(bookTitle: "", host: "", path: "", method: .get)
        //when
        netWorkHandler.request(api: testAPIModel) { data in
            switch data {
            case .success(_):
                XCTFail()
            case .failure(let error):
                //then
                XCTAssertEqual(error, APIError.transportError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_netWorkManger의_request호출시_statusCode가_불안정할경우_responseError를_잘던지는지() {
        //given
        let promise = expectation(description: "responseError와 일치하는지")
        let dummyData = makeDummyData(data: Data(), statusCode: 404, error: nil)
        let netWorkHandler = NetworkManger(urlSession: StubURLSession(dummyData: dummyData))
        let testAPIModel = TestAPIModel(bookTitle: "", host: "", path: "", method: .get)
        //when
        netWorkHandler.request(api: testAPIModel) { data in
            switch data {
            case .success(_):
                XCTFail()
            case .failure(let error):
                //then
                XCTAssertEqual(error, APIError.responseError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_netWorkManger의_request호출시_data가nil일경우_dataError를_잘던지는지() {
        //given
        let promise = expectation(description: "dataError와 일치하는지")
        let dummyData = makeDummyData(data: nil, statusCode: 200, error: nil)
        let netWorkHandler = NetworkManger(urlSession: StubURLSession(dummyData: dummyData))
        let testAPIModel = TestAPIModel(bookTitle: "", host: "", path: "", method: .get)
        //when
        netWorkHandler.request(api: testAPIModel) { data in
            switch data {
            case .success(_):
                XCTFail()
            case .failure(let error):
                //then
                XCTAssertEqual(error, APIError.dataError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
