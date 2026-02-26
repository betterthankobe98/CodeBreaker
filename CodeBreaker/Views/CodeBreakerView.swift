//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/4.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: Data Owned by Me
    @State private var game = CodeBreaker()
    @State private var selection = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            restartButton
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guessCode, selection: $selection) {
                        guessButton
                    }
                }
                ForEach(game.temptCode.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.temptCode[index]) {
                        if let matches = game.temptCode[index].matches {
                            MatchMarkerView(matches: matches)
                        }
                    }
                }
            }
            PegChooserView(pegs: game.pegChoice) { peg in 
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.guessCode.pegs.count
            }
        }
        .padding()
    }

    var restartButton: some View {
        Button("RESTART") {
            game = CodeBreaker()
            selection = 0
        }
        .font(.system(size:50))
    }
    
    var guessButton: some View {
        Button("GUESS") {
            game.playGuess()
            selection = 0
        }
        .font(.system(size:GuessButton.maximumFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    struct GuessButton {
        static let minimumFontSize: CGFloat = 8
        static let maximumFontSize: CGFloat = 80
        static let scaleFactor = minimumFontSize / maximumFontSize
    }
    
    
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

#Preview {
    CodeBreakerView()
}
