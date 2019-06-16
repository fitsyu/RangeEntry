import UIKit

import MultiSlider

public class RangeEntryViewDefault: UIView, RangeEntryView {
    
    public var startValueDisplayName: String = "from" {
        didSet { setupLabels() }
    }
    public var endValueDisplayName: String   = "to" {
        didSet { setupLabels() }
    }
    
    
    public var backing: RangeEntry = RangeEntry() {
        didSet {
            setupSlider()
            startTextField.text = String(backing.start)
            endTextField.text = String(backing.end)
        }
    }
    
    public var delegate: RangeEntryViewDelegate?
    
    // MARK: Construction
    private var view: UIView!
    
    public override func awakeFromNib() {
        let nib = bundle.loadNibNamed("RangeEntryViewDefault", owner: self, options: nil)
        
        view = (nib?.first as! UIView)
        view.frame = self.bounds
        self.addSubview(view)
        
        setupLabels()
        setupTextFields()
        setupSlider()
    }
    
    private lazy var bundle: Bundle = {
        
        let url = Bundle(for: self.classForCoder).url(forResource: "RangeEntry", withExtension: "bundle")
        if url == nil {
            print("failed to load bundle")
        }
        
        let bundle = Bundle(url: url!)
        if bundle == nil {
            print("failed to load bundle")
        }
        
        return bundle!
    }()
    
    public override var intrinsicContentSize: CGSize {
        let size = view.bounds.size
        return size
    }
    
    // MARK: What we care
    @IBOutlet weak var startlabel: UILabel!
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var endTextField: UITextField!
    
    private func setupLabels() {
        startlabel.text = startValueDisplayName
        endLabel.text   = endValueDisplayName
    }
    
    @IBOutlet weak var slider: MultiSlider!
    
    private var activeTextField: UITextField?
    
    func setupTextFields() {

        let width  = view.frame.width
        let height = CGFloat(40.0)
        let frame  = CGRect(x: 0, y: 0, width: width, height: height)
        let toolbar = UIToolbar(frame: frame)
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(closeTextField))
        toolbar.items = [ space, doneButton ]
        
        
        [startTextField, endTextField].forEach {
            $0?.inputAccessoryView = toolbar
            $0?.delegate = self
        }
    }
    
    func setupSlider() {
        slider.orientation = .horizontal

        print(backing.start, backing.end)
        let start = CGFloat(backing.start)
        let end   = CGFloat(backing.end)

        slider.minimumValue = start
        slider.maximumValue = end
        slider.value       = [start, end]
    }
    
    @IBAction func sliderValueChanged(_ sender: MultiSlider) {
        
        guard
            let startValue = sender.value.first,
            let endValue   = sender.value.last
            else {
                dump(sender.value)
                return
        }
        
        // model update
        backing.start = Int(startValue)
        backing.end   = Int(endValue)
        
        // view update
        startTextField.text = "\(backing.start)"
        endTextField.text   = "\(backing.end)"
        
        // delegate update
        delegate?.didUpdateRange(self, range: backing.range())
   
    }
}


extension RangeEntryViewDefault: UITextFieldDelegate {
    
    @objc func closeTextField() {

        guard let textField = activeTextField else {
            print("there should be one active textField")
            return
        }
        
        activeTextField?.resignFirstResponder()
        
        guard let value = Int(textField.text!)  else {
            print ("value couldn't be converted to int")
            return
        }

        switch textField {
        case startTextField:
            backing.start = value

        case endTextField:
            backing.end = value

        default:
            print("unknown text field")
            break
        }

        let newRange = backing.range()
        delegate?.didUpdateRange(self, range: newRange)
        
        backing = RangeEntry(start: newRange.start, end: newRange.end)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeTextField()
        return true
    }
}
