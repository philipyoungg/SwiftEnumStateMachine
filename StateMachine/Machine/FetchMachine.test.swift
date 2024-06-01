//
//  StateMachineTests.swift
//  StateMachineTests
//
//  Created by Philip Young on 2024-06-01.
//

import XCTest
@testable import StateMachine

final class StateMachineTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialStateIsIdle() throws {
        let state = FetchStateMachine<Int>.idle
        XCTAssertTrue(state == .idle)
    }
    
    func testStateToLoadingWhenFetch() throws {
        var state = FetchStateMachine<Int>.idle
        let effect = state.transition(.fetch)
        XCTAssertTrue(state == .loading)
        XCTAssertTrue(effect == [.fetchData])
    }
    
    func testLoadingSuccessWithCorrectData() throws {
        var state = FetchStateMachine<Int>.loading
        let _ = state.transition(.fetchSuccess([30]))
        XCTAssertTrue(state == .loaded([30]))
    }
    
    func testNoEffectCalledWhenFetchIsStillLoading() throws {
        var state = FetchStateMachine<Int>.loading
        let effects = state.transition(.fetch)
        XCTAssertTrue(effects.isEmpty)
    }
}
