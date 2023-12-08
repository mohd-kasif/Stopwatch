//
//  stopwatchApp.swift
//  stopwatch
//
//  Created by Kashif on 06/12/23.
//

import SwiftUI

@main
struct stopwatchApp: App {
//    let viewContext=DataMagager.shared.container.viewContext
//    @StateObject private var lapRecordController=StopWatchViewModel()
    var body: some Scene {
        WindowGroup {
//            StopWatchView(viewModel:StopWatchViewModel(moc:viewContext))
            StopWatchView()
//                .environment(\.managedObjectContext,viewContext)
        }
    }
}
