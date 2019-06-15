import XCTest
import RangeEntry

class Tests: XCTestCase {
    
    var priceRange: RangeEntry!
    
    override func setUp() {
        
        priceRange = RangeEntry()
    }
    
    func testDefaultConstruction() {
        
        guard let priceRange = priceRange else { XCTFail() }
        
        XCTAssertEqual(priceRange.startValue, 0)
        XCTAssertEqual(priceRange.endValue,   0)
        XCTAssertEqual(priceRange.range(), (start: 0, end: 0))
    }
    
    func testNormalConstruction() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        XCTAssertEqual(priceRange.startValue, 10)
        XCTAssertEqual(priceRange.endValue,   20)
        XCTAssertEqual(priceRange.range(), (start: 10, end: 20))
    }
    
    func testAntiPatternConstruction() {
        
        priceRange = RangeEntry(start: 20, end: 10) // we prioritize start value
        
        XCTAssertEqual(priceRange.startValue, 20)
        XCTAssertEqual(priceRange.endValue,   20)
        XCTAssertEqual(priceRange.range(), (start: 20, end: 20))
    }
    
    func testIncorrectConstruction() {
        
        priceRange = RangeEntry(start: -1, end: 10)
        
        XCTAssertEqual(priceRange.state, RangeEntryState.InvalidRange)
    }
    
    func testStartCanBeUpdated() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.start = 15
        
        XCTAssertEqual(priceRange.startValue, 15)
        XCTAssertEqual(priceRange.endValue,   20, "when it is normal, end shouldn't get affected")
        XCTAssertEqual(priceRange.range(), (start: 15, end: 20))
    }
    
    func testEndCanBeUpdated() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.end = 25
        
        XCTAssertEqual(priceRange.startValue, 10, "when it is normal, start shouldn't get affected")
        XCTAssertEqual(priceRange.endValue,   25)
        XCTAssertEqual(priceRange.range(), (start: 10, end: 25))
    }
    
    func testIncorrectUpdate() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.start = -10
        
        XCTAssertEqual(priceRange.state, RangeEntryState.InvalidRange)
    }
    
    func testItNotifiesUpdates() {
        
        class ADelegate: RangeEntryUIDelegate {
            
            var updated: Bool = false
            func didUpdateRange(_ ui: RangeEntryUI, range: (start: Int, end: Int)) {
                self.updated = true
            }
        }
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        let ui: RangeEntryUI = RangeEntryUIDefault()
        ui.backing = priceRange
        
        let uiDelegate: RangeEntryUIDelegate = ADelegate()
        ui.delegate = uiDelegate
        
        // act
        ui.backing.start = 15
        
        // assert
        XCTAssertTrue(uiDelegate.updated, "when delegate is set, it should get notified")
    }

}
