//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by 王峥 on 2026/2/4.
//

import SwiftUI

enum Match {
    case right
    case wrong
    case half
}

struct MatchMarkerView: View {
    
    // MARK: Data In
    var matches: [Match]
    
    // MARK: - Body
    var body: some View {
        VStack{
            HStack{
                Matchers(peg: 0)
                Matchers(peg: 1)
                Matchers(peg: 2)
            }
            HStack{
                Matchers(peg: 3)
                Matchers(peg: 4)
                Matchers(peg: 5)
            }
        }
    }
    
    func Matchers(peg: Int) -> some View {
//        let rightCount = matches.filter{ $0 == Match.right }.count
        let rightCount = matches.count(where: { $0 == .right })
        let halfCount = matches.count(where: { $0 != Match.wrong })
        return Circle()
            .fill(peg < rightCount ? Color.primary : Color.clear)
            .strokeBorder(peg < halfCount ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
        
    }
}

#Preview {
    MatchMarkersPreview()
//    MatchMarkers(matches: [.half, .right, .wrong, .right, .right, .right])
//    MatchMarkers(matches: [.half, .half, .wrong, .right, .right, .half])
//    MatchMarkers(matches: [.half, .right, .wrong, .right, .right, .wrong])
}

struct MatchMarkersPreview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Line(circleCount: 1)
            Line(circleCount: 2)
            Line(circleCount: 3)
            Line(circleCount: 4)
            Line(circleCount: 5)
            Line(circleCount: 6)
//            Line(circleCount: 7)
//            Line(circleCount: 8)
        }
    }
}

struct Line: View {
    var circleCount: Int
    var body: some View {
        HStack{
            ForEach(0..<circleCount, id: \.self) { _ in
                Circle()
                    .foregroundStyle(.primary)
            }
            MatchMarkerView(matches: [.half, .right, .wrong, .right, .right])
        }.padding()
        
    }
}
