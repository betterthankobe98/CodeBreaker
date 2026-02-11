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
        masterCode = Code(kind: .master, pegsCount: pegCounts)
        guessCode = Code(kind: .guess, pegsCount: pegCounts)
        masterCode.randomize(count: pegCounts, from: pegChoice)
    }
    
    mutating func playGuess() {
        var currentGuess = guessCode
        currentGuess.kind = .tempt(currentGuess.match(against: masterCode))
        if temptCode.contains(currentGuess) || currentGuess.pegs.allSatisfy({ $0 == Peg.missingPeg }) {
            return
        }
        temptCode.append(currentGuess)
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


struct Code: Equatable {
    
    var kind: Kind
    var pegs: [Peg]
    
    init(kind: Kind, pegsCount: Int) {
        self.kind = kind
        self.pegs = Array(repeating: Peg.missingPeg, count: pegsCount)
    }
       
    enum Kind: Equatable {
        case master
        case guess
        case tempt([Match])
    }
    
    var matches: [Match]? {
        switch kind {
            case .tempt(let matches): return matches
            default: return nil
        }
    }
    
    mutating func randomize(count: Int, from pegChoices: [Peg]) {
        for index in 0..<count {
            pegs[index] = pegChoices.randomElement() ?? Peg.missingPeg
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        // function programming version: map
        var pegsToMatch = otherCode.pegs
        let exactMatchInReverse = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.right
            } else {
                return .wrong
            }
        }
        let exactMatch = Array(exactMatchInReverse.reversed())
        return pegs.indices.map { index in
            if exactMatch[index] != Match.right, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .half
            } else {
                return exactMatch[index]
            }
        }
        // old version
//        var results: [Match] = Array(repeating: .wrong, count: pegs.count)
//        var pegsToMatch = otherCode.pegs
//        for index in pegs.indices.reversed() {
//            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
//                results[index] = .right
//                pegsToMatch.remove(at: index)
//            }
//        }
//        for index in pegs.indices {
//            if results[index] != .right {
//                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
//                    results[index] = .half
//                    pegsToMatch.remove(at: matchIndex)
//                }
//            }
//        }
//        return results
    }
}
