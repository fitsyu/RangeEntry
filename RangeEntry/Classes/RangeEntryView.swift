
public protocol RangeEntryView {
    
    var backing: RangeEntry { get set }
    var delegate: RangeEntryViewDelegate? { get set}
}
