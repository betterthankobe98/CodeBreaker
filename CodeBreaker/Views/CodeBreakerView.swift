//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/4.
//

import SwiftUI

struct CodeBreakerView: View {
    
    // MARK: Data In
    @State private var game = CodeBreaker()
    @State private var selection = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            restartButton
            view(for: game.masterCode)
            ScrollView {
                if !game.isOver {
                    view(for: game.guessCode)
                }
                ForEach(game.temptCode.indices.reversed(), id: \.self) { index in
                    view(for: game.temptCode[index])
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
    
    func view(for code: Code) -> some View {
        HStack{
            CodeView(code: code, selection: $selection)
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkerView(matches: matches)
                    } else {
                        if code.kind == .guess {
                            guessButton
                        }
                    }
                }
        }
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
