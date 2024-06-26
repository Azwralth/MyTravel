//
//  NoteViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import SwiftUI

final class NoteViewModel: ObservableObject {
    @Published var showCreateNoteView = false
    @Published var isSortedDate = false
    
    func showTextSort() -> String {
        isSortedDate ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle"
    }
}

