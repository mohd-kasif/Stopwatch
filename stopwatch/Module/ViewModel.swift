//
//  ViewModel.swift
//  stopwatch
//
//  Created by Kashif on 06/12/23.
//

import Foundation
import Combine
import CoreData
import SwiftUI

// Declaring Mode for stopwatch
/// threre are only three mode for stopwatch right now
enum Mode{
    case start
    case pause
    case reset
}


class StopWatchViewModel:ObservableObject{
    let container:NSPersistentContainer
    @Published var seconds:TimeInterval=0
    @Published var mode:Mode = .start
    @Published var lapTimes:[Laps]=[]
    let dataTable=NSPersistentContainer(name: "LapRecordTable")
    var lastTime:TimeInterval=0
    var timer=Timer()
    var lastLap:TimeInterval=0
    init(){
        container=NSPersistentContainer(name: "LapRecordTable")
        container.loadPersistentStores{des,err in
            if let err=err{
                print(err,"unable to load data")
            }
        }
        fetchLaps()
    }
    
    // this function decide whcih operation to perform
    func startStopwatch(mode:Mode){
        switch mode{
        case .start:
            self.mode = .pause
            timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){[weak self] time in
                guard let self=self else {return}
                self.seconds+=time.timeInterval
            }
        case .pause:
            self.mode = .start
            timer.invalidate()
        case .reset:
            self.mode = .start
            timer.invalidate()
            seconds=0
            lastTime=0
            deleteLapRecords()
            self.lapTimes=[]
            lastLap=0
        }
    }
    
    // fetching stored laps values
    func fetchLaps(){
        let request=NSFetchRequest<Laps>(entityName: "Laps")
        do {
            lapTimes=try container.viewContext.fetch(request)
        } catch let error{
            print("error while fetching",error)
        }
    }
    
    // in this function we are storing Laps value
    func saveLap(){
        let lapTime=seconds-lastLap
        let formattedLapTime=formatElapsedTime(lapTime)
        let newLap=Laps(context: container.viewContext)
        newLap.id=UUID()
        newLap.lapTime=formattedLapTime
        lastLap=seconds
        do {
            try container.viewContext.save()
            fetchLaps()
        } catch let error{
            print("error while saving",error)
        }
    }
    
    // here we are deleting all values of laps record.
    func deleteLapRecords() {
        let request = NSFetchRequest<Laps>(entityName: "Laps")
        do {
            let lapRecords = try container.viewContext.fetch(request)
            for record in lapRecords {
                container.viewContext.delete(record)
            }
            try container.viewContext.save()
        } catch let error {
            print("Error deleting lap records:", error)
        }
    }
    
    
    // Returning a desired format of string of time in 00:00:00(minutes:seconds:milliseconds)
    func formattedString()->String{
        let minutes = Int(seconds) / 60 % 60
        let sec = Int(seconds) % 60
        let milliseconds = Int((Double(seconds * 100)).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d:%02d", minutes, sec, milliseconds)
    }
    
    // returing formatted string of lap time
    private func formatElapsedTime(_ time: TimeInterval) -> String {
          let minutes = Int(time) / 60 % 60
          let sec = Int(time) % 60
          let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
          return String(format: "%02d:%02d:%02d", minutes, sec, milliseconds)
      }
    func formattedElapsedTime() -> String {
           return formatElapsedTime(seconds)
       }
}
