//
//  ViewController.swift
//  RangeEntry
//
//  Created by fitsyu on 06/15/2019.
//  Copyright (c) 2019 fitsyu. All rights reserved.
//

import UIKit
import RangeEntry

class ViewController: UIViewController {

    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var priceRangeView: RangeEntryViewDefault!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRangeEntry()
    }
}


extension ViewController {
    
    func makeRangeEntry() {
        
        let prange = RangeEntry(start: 10, end: 100)
        
//        let prangeView = RangeEntryViewDefault()
//        prangeView.frame = priceRangeEntryViewContainer.bounds
//        priceRangeEntryViewContainer.addSubview(prangeView)
        
        priceRangeView.startValueDisplayName = "Minimum"
        priceRangeView.endValueDisplayName   = "Maximum"
        
        priceRangeView.backing = prange
        priceRangeView.delegate = self
    }
}

extension ViewController: RangeEntryViewDelegate {
    
    func didUpdateRange(_ view: RangeEntryView, range: RangeEntry.Range) {
        
        let text = "min:\(range.start) max: \(range.end)"
        priceRangeLabel.text = text
    }
}

