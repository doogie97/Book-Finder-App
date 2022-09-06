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
    
//    func test_안녕_검색시_data를정상적으로받아오는지() {
//        let promise = expectation(description: "id가 일치 하는지")
//
//        let networkHandler = NetworkHandler()
//
//        networkHandler.request(api: APIModel(bookTitle: "안녕", startIndex: 0, maxResult: 1, method: .get)) { result in
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data, "asdf")
//            case .failure(_):
//                XCTFail()
//            }
//            promise.fulfill()
//        }
//        wait(for: [promise], timeout: 20)
//    }
}
