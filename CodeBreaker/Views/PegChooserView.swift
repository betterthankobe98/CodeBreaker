//
//  PegChooserView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/12.
//

import SwiftUI

struct PegChooserView: View {
    
    // MARK: Data In
    let pegs: [Peg]
    
    // MARK: - ！在结构体内自定义闭包参数并使用！
    // MARK: Data Out Func
    let onChoose: ((Peg) -> Void)?

    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(pegs, id: \.self) { peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
}

#Preview {
    var pre_game = CodeBreaker()
    HStack {
        PegChooserView(pegs: pre_game.pegChoice) { peg in
            pre_game.setGuessPeg(peg, at: 1)
        }
    }.padding()
}
