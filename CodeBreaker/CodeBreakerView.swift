//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/4.
//

import SwiftUI

struct CodeBreakerView: View {
    
    @State var game = CodeBreaker()
    
    static let missing = Color.clear
    static let colorMap: [String : Color] = [
        "brown" : .brown,
        "yellow" : .yellow,
        "purple" : .purple,
        "gray" : .gray,
        "blue" : .blue,
        "orange" : .orange
    ]
    
    var body: some View {
        VStack {
            restartButton
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guessCode)
                ForEach(game.temptCode.indices.reversed(), id: \.self) { index in
                    view(for: game.temptCode[index])
                }
            }
        }
        .padding()
    }
    
    var restartButton: some View {
        Button("RESTART") {
            game = CodeBreaker()
        }
        .font(.system(size:50))
    }
    
    var guessButton: some View {
        Button("GUESS") {
            game.playGuess()
        }
        .font(.system(size:80))
        .minimumScaleFactor(0.1)
    }
    
    func view(for code: Code) -> some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self) { number in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(CodeBreakerView.colorMap[code.pegs[number]] ?? CodeBreakerView.missing)
//                    .strokeBorder(code.kind == .guess ? Color.black : Color.clear, lineWidth: 2)
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    
                    .overlay {
                        if CodeBreakerView.colorMap[code.pegs[number]] == nil {
                            Text(code.pegs[number])
                                .font(.system(size: 120))
                                .minimumScaleFactor(9/120)
                        }
                    }
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
