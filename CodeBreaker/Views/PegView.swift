//
//  PegView.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/12.
//

import SwiftUI

struct PegView: View {
    
    // MARK: Data In
    let peg: Peg
    let pegShape = RoundedRectangle(cornerRadius: 10)
    
    static let missing = Color.clear
    static let colorMap: [String : Color] = [
        "brown" : .brown,
        "yellow" : .yellow,
        "purple" : .purple,
        "gray" : .gray,
        "blue" : .blue,
        "orange" : .orange
    ]
    
    // MARK: - Body
    var body: some View {
        pegShape
            .fill(PegView.colorMap[peg] ?? PegView.missing)
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
            .overlay {
                if PegView.colorMap[peg] == nil {
                    Text(peg)
                        .font(.system(size: 120))
                        .minimumScaleFactor(9/120)
                }
                if peg == Peg.missingPeg {
                    pegShape
                        .strokeBorder(Color.gray)
                }
            }
    }
}

#Preview {
    PegView(peg: "🖤")
}
