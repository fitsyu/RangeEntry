//
//  RangeEntryViewTest.swift
//  RangeEntry_Tests
//
//  Created by Fitsyu  on 15/06/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import RangeEntry

class RangeEntryViewTest: XCTest {
    
    func testItNotifiesUpdates() {

        class ADelegate: RangeEntryViewDelegate {

            var updated: Bool = false
            func didUpdateRange(_ ui: RangeEntryView, range: RangeEntry.Range) {
                self.updated = true
            }
        }

        let priceRange = RangeEntry(start: 10, end: 20)

        var ui: RangeEntryView = RangeEntryViewDefault()
        ui.backing = priceRange

        let aDelegate = ADelegate()
        let uiDelegate: RangeEntryViewDelegate = aDelegate
        ui.delegate = uiDelegate

        // act
        ui.backing.start = 15

        // assert
        XCTAssertTrue(aDelegate.updated, "when delegate is set, it should get notified")
    }
}
