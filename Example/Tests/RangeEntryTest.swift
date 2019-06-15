import XCTest
import RangeEntry

class RangeEntryTests: XCTestCase {
    
    var priceRange: RangeEntry!
    
    override func setUp() {
        
        priceRange = RangeEntry()
    }
    
    func testDefaultConstruction() {
        
        guard let priceRange = priceRange else { XCTFail(); return }
        
        XCTAssertEqual(priceRange.start, 0)
        XCTAssertEqual(priceRange.end,   0)
    }
    
    func testNormalConstruction() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        XCTAssertEqual(priceRange.start, 10)
        XCTAssertEqual(priceRange.end,   20)
    }
    
    func testAntiPatternConstruction() {
        
        priceRange = RangeEntry(start: 20, end: 10) // we prioritize start value
        
        XCTAssertEqual(priceRange.start, 20)
        XCTAssertEqual(priceRange.end,   20)
    }
    
    func testIncorrectConstruction() {
        
        priceRange = RangeEntry(start: -1, end: 10)
        
        XCTAssertEqual(priceRange.state, RangeEntryState.InvalidRange)
    }
    
    func testStartCanBeUpdated() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.start = 15
        
        XCTAssertEqual(priceRange.start, 15)
        XCTAssertEqual(priceRange.end,   20, "when it is normal, end shouldn't get affected")
    }
    
    func testEndCanBeUpdated() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.end = 25
        
        XCTAssertEqual(priceRange.start, 10, "when it is normal, start shouldn't get affected")
        XCTAssertEqual(priceRange.end,   25)
    }
    
    func testIncorrectUpdate() {
        
        priceRange = RangeEntry(start: 10, end: 20)
        
        priceRange.start = -10
        
        XCTAssertEqual(priceRange.state, RangeEntryState.InvalidRange)
    }
    
    func testGetRange() {
        
        priceRange = RangeEntry(start: 0, end: 100)
        
        priceRange.start = 20
        priceRange.end   = 80
        
        let updatedRange = priceRange.range()
        
        XCTAssertEqual(updatedRange.start, 20)
        XCTAssertEqual(updatedRange.end,   80)
    }

}
