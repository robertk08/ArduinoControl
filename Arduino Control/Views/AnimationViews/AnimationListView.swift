//
//  AnimationListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct AnimationListView: View {
    @ObservedObject var storage = AnimationStorage.shared
    @State private var isAnimationSettingsViewPresent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(storage.animations.indices, id: \.self) { index in
                    NavigationLink {
                        SingleAnimationView(index: index)
                    } label: {
                        Text(storage.animations[index].name)
                    }
                }
                .onDelete { indices in
                    Haptic.feedback(.success)
                    storage.animations.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    Haptic.feedback(.medium)
                    storage.animations.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .navigationTitle("Animations")
            .sheet(isPresented: $isAnimationSettingsViewPresent) {
                AnimationSettingsView(isNewAnimation: true, name: "", delay: 0.5, repeating: true, matrixes: [])
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Haptic.feedback(.selection)
                        isAnimationSettingsViewPresent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    AnimationListView()
}
