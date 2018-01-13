//
//  UIPicker.swift
//  DinnerSpinner
//
//  Created by Dide van Berkel on 13/01/2018.
//  Copyright © 2018 Digithio. All rights reserved.
//

import UIKit

protocol UIPickerDelegate {
    
    func pickerView(inputAccessoryViewFor pickerView: UIPicker) -> UIView?
    func pickerView(didSelect value: String, inRow row: Int, delegatedFrom pickerView: UIPicker)
    
}

class UIPicker: NSObject {
    
    var delegate: UIPickerDelegate? {
        didSet {
            textView.inputAccessoryView = delegate?.pickerView(inputAccessoryViewFor: self)
        }
    }
    
    fileprivate let pickerView = UIPickerView()
    fileprivate var textView = UITextField()
    fileprivate weak var parentViewController: UIViewController?
    public fileprivate(set) var items: [String] = []
    
    init (parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
        setupPickerView()
    }
    
    deinit {
        textView.removeFromSuperview()
    }
}

// MARK: - Getter and Setter

extension UIPicker {
    
    func set(items: [String]) {
        self.items = items
        pickerView.reloadAllComponents()
    }
    
    var selectedItem: String {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        return items[selectedRow]
    }
}


// MARK: - setup Views

extension UIPicker {
    
    fileprivate func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        textView.inputView = pickerView
        parentViewController?.view.addSubview(textView)
    }
    
    func startPicking() {
        textView.becomeFirstResponder()
    }
    
    func endPicking() {
        textView.resignFirstResponder()
    }
    
}


// MARK: - UIPickerViewDataSource

extension UIPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
}

// MARK: - UIPickerViewDelegate

extension UIPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(didSelect: items[row], inRow: row, delegatedFrom: self)
    }
    
}
