//
//  ViewController.swift
//  Project2
//
//  Created by Jason Cox on 5/26/20.
//  Copyright © 2020 Jason Cox. All rights reserved.
//

import Cocoa

// Before working with NSTableView, make the ViewController conform to both NSTableViewData and NSTableView Delegate
class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet var Guess: NSTextField!
    @IBOutlet var tableView: NSTableView!
    
    // of note: in the lession, the @IBOutlet var is guess instead of Guess - I need to make sure I adjust all of my code accordingly
    // create variables to store the number and guesses
    var answer = ""
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func submitGuess(_ sender: Any) {
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func result (for guess: String) -> String {
        return "Result"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
            return nil
        }
            if tableColumn?.title == "Guess" {
                //this is the Guess column, show a previous guess
                vw.textField?.stringValue = guesses[row]
            } else {
                // this is the Result column, call our new method
                vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame(){
        Guess.stringValue = ""
        guesses.removeAll()
        answer = ""
        
        var numbers = Array(0...9)
        numbers.shuffle()
        
        for _ in 0 ..< 4 {
            answer.append(String(numbers.removeLast()))
        }
    }
}

