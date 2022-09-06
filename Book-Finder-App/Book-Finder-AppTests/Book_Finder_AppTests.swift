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
    
    //MARK: - NetworkHandler 테스트
    func test_행복_이라는title로_NetworkHandler의_request메서드호출시_첫번째책의title이_행복을_풀다_와일치하는지() {
        //api상황에 따라 결과 상이할 수 있어 실제 api와 비교 테스트 필요
        
        //given
        let promise = expectation(description: "행복을 풀다와 일치하는지")

        let networkHandler = NetworkHandler()
        let dataDecoder = DataDecoder()
        
        networkHandler.request(api: APIModel(bookTitle: "행복", startIndex: 0, maxResult: 10, method: .get)) { apiResult in
            switch apiResult {
            case .success(let data):
                guard let searchResult = try? dataDecoder.parse(data: data, resultType: SearchResult.self) else {
                    XCTFail()
                    return
                }
                let result = searchResult.items?[0].volumeInfo?.title
                print(searchResult)
                XCTAssertEqual(result, "행복을 풀다")
            case .failure(_):
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
    }
}
