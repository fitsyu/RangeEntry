
public enum RangeEntryState {
    case OK
    case InvalidRange
    case Unknown(hint: String)
}

extension RangeEntryState: Equatable {}



public class RangeEntry {
    
    public typealias Range = (start: Int, end: Int)
    
    public var state: RangeEntryState
    
    public var start: Int = 0 {
        didSet {
            checkStart()
        }
    }
    
    public var end: Int = 0 {
        didSet {
            checkEnd()
        }
    }
    
    public func range() -> Range {
        return Range(start: start, end: end)
    }
    
    public init() {
        state = .OK
        start = 0
        end   = 0
    }
    
    public init(start: Int, end: Int) {
        state = .OK
        
        self.start = start
        self.end   = end
        
        checkStart()
        checkEnd()
    }
    
    private func checkStart() {
        if start < 0 {
            state = .InvalidRange
            start = 0
        }
        
        // the anti-pattern
        if start > end {
            end = start
        }
    }
    
    private func checkEnd() {
        if end < 0 {
            state = .InvalidRange
            end = 0
        }
        
        // the anti-pattern
        if end < start {
            start = end
        }
    }
}
