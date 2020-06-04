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
        
        // check for 4 unique characters
        let guessString = Guess.stringValue
        guard Set(guessString).count == 4 else { return }; guard guessString.count == 4 else { return }
        
        // ensure there are no non-digit characters
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        // add the guess to the array and table view
        guesses.insert(guessString, at: 0)
        
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        // did the player win?
        let resultString = result(for: guessString)
        
        if resultString.contains("4b") {
            let alert = NSAlert()
            let count = guesses.count
            alert.messageText = "You Won in \(count) guesses"
            if count > 20 {
                alert.informativeText = "Congratulations! Click OK to play again."
                alert.runModal()
            } else if count < 10 {
                alert.informativeText = "That's Awesome! Click OK to play again"
                alert.runModal()
            } else {
                alert.informativeText = "Not too shabby! Click OK to play again"
                alert.runModal()
            }
            
            startNewGame()
        }
        
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func result(for Guess: String) -> String {
        var bulls = 0
        var cows = 0
        let guessLetters = Array(Guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    
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

