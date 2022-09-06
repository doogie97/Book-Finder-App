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
        guard let searchResult = try? dataDecoder.parse(data: data) else {
            //then
            XCTFail()
            return
        }
        
        let result = searchResult.items?[0].volumeInfo?.title
        
        //then
        XCTAssertEqual(result, "안녕")
    }
    
    func test_testSearchResult를_DataDecoder의_decode메서드로parsing시_1번째책의readingModes중_image가_true인지() {
        //given
        let dataDecoder = DataDecoder()
        let data = dataFromJson(fileName: "testSearchResult")
        
        //when
        guard let searchResult = try? dataDecoder.parse(data: data) else {
            //then
            XCTFail()
            return
        }
        
        let result = searchResult.items?[1].volumeInfo?.readingModes?.image
        
        //then
        XCTAssertEqual(result, true)
    }
}
