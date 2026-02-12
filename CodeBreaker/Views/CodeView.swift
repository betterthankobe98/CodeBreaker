//
//  CodeView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/12.
//

import SwiftUI

struct CodeView: View {
    
    // MARK: Data In
    let code: Code
    
    // MARK: Data Shared Between Views
    @Binding var selection: Int
    
    // MARK: - Body
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { number in
            PegView(peg: code.pegs[number])
                .background {
                    if number == selection, code.kind == .guess {
                        Selection.shape
                            .foregroundStyle(Selection.color)
                    }
                }
                .overlay{
                    Selection.shape
                        .foregroundStyle(code.isHidden ? Color.gray : Color.clear)
                }
                .onTapGesture {
                    if code.kind == .guess {
//                            game.changeGuessPeg(at: number)
                        selection = number
                    }
                }
            }
    }
    
    struct Selection {
        static let border: CGFloat = 5
        static let cornerRadius: CGFloat = 10
        static let color: Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    }
}

#Preview {
    HStack {
        CodeView(code: Code(kind: .master(isHidden: true), pegsCount: 5), selection: Binding<Int>.constant(3))
    }.padding()
}
