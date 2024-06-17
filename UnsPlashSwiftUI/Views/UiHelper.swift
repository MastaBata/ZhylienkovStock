//
//  UiHelper.swift
//  ZhylienkovStock
//
//  Created by Oleksii Zhylienkov on 14/06/24.
//

import Foundation
import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
    
    func inputIconStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
    }
}
