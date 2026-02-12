//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/9.
//

import Foundation

typealias Peg = String

struct CodeBreaker {
    
    static let supportedemojis = ["💜","🩵","🧡","💚","💛","💙"]
    static let supportedColors = ["brown", "yellow", "purple", "gray", "blue", "orange"]
    
    var masterCode: Code
    var guessCode: Code
    var temptCode: [Code] = []
    
    let pegChoice: [Peg]
    let pegCounts: Int
        
    init(pegKind: Bool = Bool.random()) {
        if pegKind {
            pegChoice = CodeBreaker.supportedColors
        } else {
            pegChoice = CodeBreaker.supportedemojis
        }
        pegCounts = Int.random(in: 3...6)
        masterCode = Code(kind: .master(isHidden: true), pegsCount: pegCounts)
        guessCode = Code(kind: .guess, pegsCount: pegCounts)
        masterCode.randomize(count: pegCounts, from: pegChoice)
        print(masterCode.pegs)
    }
    
    var isOver: Bool {
        temptCode.last?.pegs == masterCode.pegs
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int) {
        guard guessCode.pegs.indices.contains(index) else { return }
        guessCode.pegs[index] = peg
    }
    
    mutating func playGuess() {
        var currentGuess = guessCode
        currentGuess.kind = .tempt(currentGuess.match(against: masterCode))
        if temptCode.contains(currentGuess) || currentGuess.pegs.allSatisfy({ $0 == Peg.missingPeg }) {
            return
        }
        temptCode.append(currentGuess)
        guessCode.reset(times: currentGuess.pegs.count)
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let currentPeg = guessCode.pegs[index]
        if let ExistingIndexofCurrentPeg = pegChoice.firstIndex(of: currentPeg) {
            guessCode.pegs[index] = pegChoice[(ExistingIndexofCurrentPeg + 1) % pegChoice.count]
        } else {
            guessCode.pegs[index] = pegChoice.first ?? Peg.missingPeg
        }
    }
    
}


extension Peg {
    static let missingPeg: Peg = ""
}



