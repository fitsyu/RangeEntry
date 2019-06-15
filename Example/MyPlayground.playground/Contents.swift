import XCTest
//import RangeEntry

class Tests: XCTestCase {
    
    func testItWorks() {
        
        
//        let priceRange: RangeEntry = RangeEntry(from: 0, to: 1_000)
//
//        // Construction
//        RangeEntry() // start 0, end 0
//        RangeEntry(0, 10) // without label
//        RangeEntry(start: 0, end: 10) // labeled
//        RangeEntry(from: 0, to: 10) // with from, to label
//        RangeEntry(min: 0, max: 10) // with min, max label
//
//        // setters with functions
//        priceRange.setStart(value: 2)
//        priceRange.setEnd(value:  8)
//
//        // setters using public properties assignment
//        priceRange.start = 200
//        priceRange.end   = 300
//
//        // getters
//        priceRange.range // NSRange(2 - 8)
//
//        priceRange.start() // 2
//        priceRange.end() // 8
        
        // anti-pattern
        // case 1:
        // start value set above end value
        // r = Range(5, 10)
        // r.start = 11 // what happen?
        // r.range() // Range(11, 11)
        
        // case 2:
        // end value set below start value
        // r = Range(5, 10)
        // r.end = 2 // what happen
        // r.range() // Range(2, 2)
        
//        XCTAssert(1 == 2, "One is One")
        
        
        // spec 1: normal
        // start is changable
        
        // spec 2: normal
        // end is changable
        
        // spec 3: anti-pattern
        // when start is changed above end
        // both start and end are updated to the same value
        
        // spec 4: anti-pattern
        // when end is changed below start
        // both start and end are updated to the samve value
        
        // spec 6: outside notification
        // we can know when start is changed
        
        // spec 7: outside notification
        // we can know when end is changed
        
        // spec 8: getting the result
        // we can know the range any time we want
    }
    
}

print("running the test")

let test = Tests()
let testRunner = XCTestRun(test: test)
testRunner.start()

testRunner.executionCount
testRunner.testCaseCount
testRunner.totalFailureCount

testRunner.stop()
print("done running the test")
