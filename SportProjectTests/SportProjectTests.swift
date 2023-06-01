//
//  SportProjectTests.swift
//  SportProjectTests
//
//  Created by Mac on 24/05/2023.
//

import XCTest
@testable import SportProject
final class SportProjectTests: XCTestCase {

    var networkManager:NetworkManager!
    
    override func setUpWithError() throws {
        networkManager=NetworkManager()
    }

    override func tearDownWithError() throws {
       networkManager = nil
    }

    func testgetDataWithURL1() throws {
        
        var expectation = expectation(description: "wait for API")
        
        networkManager.getData(url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")!) { (result: LeagueResponse?,error) in
           
            if let error = error {
                XCTFail()
                expectation.fulfill()
            }else{
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testgetDataWithURL2() throws {
        
        var expectation = expectation(description: "wait for API")
        
        networkManager.getData(url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=8&from=2023-06-01&to=2024-06-01&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")!) { (result: UpcomingEventResponse?,error) in
           
            if let error = error {
                XCTFail()
                expectation.fulfill()
            }else{
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testgetDataWithURL3() throws {
        
        var expectation = expectation(description: "wait for API")
        
        networkManager.getData(url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=8&from=2022-06-01&to=2023-06-01&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")!) { (result: LatestResultResponse?,error) in
           
            if let error = error {
                XCTFail()
                expectation.fulfill()
            }else{
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testgetDataWithURL4() throws {
        
        var expectation = expectation(description: "wait for API")
        
        networkManager.getData(url: URL(string: "https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=8&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")!) { (result: TeamResponse?,error) in
           
            if let error = error {
                XCTFail()
                expectation.fulfill()
            }else{
                XCTAssertNotNil(result)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
}
