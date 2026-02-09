//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/9.
//

import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guessCode: Code = Code(kind: .guess)
    var temptCode: [Code] = []
    
    let pegChoice: [Peg]
    
    init(pegChoice: [Peg] = [.red, .green, .blue, .yellow]) {
        self.pegChoice = pegChoice
        masterCode.randomize(from: pegChoice)
    }
    
    mutating func playGuess() {
        var currentGuess = guessCode
        currentGuess.kind = .tempt(guessCode.match(against: masterCode))
        temptCode.append(currentGuess)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let currentPeg = guessCode.pegs[index]
        if let ExistingIndexofCurrentPeg = pegChoice.firstIndex(of: currentPeg) {
            guessCode.pegs[index] = pegChoice[(ExistingIndexofCurrentPeg + 1) % pegChoice.count]
        } else {
            guessCode.pegs[index] = pegChoice.first ?? Code.missing
        }
    }
    
}

struct Code {
    
    static let missing: Peg = .clear
    
    var kind: Kind
    var pegs: [Peg] = Array(repeating: .clear, count: 4)
    
    enum Kind: Equatable {
        case master
        case guess
        case tempt([Match])
    }
    
    var matches: [Match] {
        switch kind {
            case .tempt(let matches): return matches
            default: return []
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .wrong, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .right
                pegsToMatch.remove(at: index)
            }
        }
        for index in pegs.indices {
            if results[index] != .right {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .half
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}
