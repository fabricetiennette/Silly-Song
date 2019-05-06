//
//  ViewController.swift
//  Silly Song
//
//  Created by Fabrice Etiennette on 06/05/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    if (fullName != "") {
        let shortName = shortNameFromName(name: fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    else
    {
        return ""
    }
}
func shortNameFromName(name: String) -> String {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let lowercaseName = name.lowercased()
    
    var shortName = ""
    if let rangeOfFirstVowel = lowercaseName.rangeOfCharacter(from: vowels) {
        //shortName = lowercaseName.substring(from: rangeOfFirstVowel.lowerBound)
        shortName = String(lowercaseName.suffix(from: rangeOfFirstVowel.lowerBound))
    } else {
        shortName = lowercaseName
    }
    
    return shortName
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameField.delegate = self
        lyricsView.isHidden = true
        nameField.becomeFirstResponder()
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
        lyricsView.isHidden = true
    }
    @IBAction func displayLyrics(_ sender: Any) {
        let name = nameField.text
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name!)
        lyricsView.isHidden = false
    }
}
