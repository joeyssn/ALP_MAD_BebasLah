//
//  StartView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI
import SwiftData

struct StartView: View {
    @EnvironmentObject var session: SessionViewModel
    var body: some View {
        NavigationStack {
            if session.isLoggedIn {
                HomeView()
            } else {
                LoginRegisterView()
            }
        }
    }
}

#Preview {
    StartView()
}
