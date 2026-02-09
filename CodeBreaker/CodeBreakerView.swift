//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/4.
//

import SwiftUI

struct CodeBreakerView: View {
    
    @State var game = CodeBreaker()
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guessCode)
                ForEach(game.temptCode.indices.reversed(), id: \.self) { index in
                    view(for: game.temptCode[index])
                }
            }
            
//            peg(colors: [.red, .primary, .primary, .blue])
//            peg(colors: [.red, .yellow, .primary, .red])
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("GUESS") {
            game.playGuess()
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
//    func peg(colors: [Color]) -> some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { number in
                RoundedRectangle(cornerRadius: 10)
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[number])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: number)
                        }
                    }
            }
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}

#Preview {
    CodeBreakerView()
}
