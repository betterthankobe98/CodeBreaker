//
//  Code.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/12.
//


import Foundation

struct Code: Equatable {
    
    var kind: Kind
    var pegs: [Peg]
    
    init(kind: Kind, pegsCount: Int) {
        self.kind = kind
        self.pegs = Array(repeating: Peg.missingPeg, count: pegsCount)
    }
       
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case tempt([Match])
    }
    
    var matches: [Match]? {
        switch kind {
            case .tempt(let matches): return matches
            default: return nil
        }
    }
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden 
        default: return false
        }
    }
    
    mutating func reset(times: Int) {
        pegs = Array(repeating: Peg.missingPeg, count: times)
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
    }
}
