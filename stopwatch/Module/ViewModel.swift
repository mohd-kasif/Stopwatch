//
//  ViewModel.swift
//  stopwatch
//
//  Created by Apple on 06/12/23.
//

import Foundation
import Combine

enum Mode{
    case start
    case pause
    case reset
    case lap
}

struct LapTimes:Identifiable{
    var id = UUID()
    var lapTimes : String
}

class StopWatchViewModel:ObservableObject{
    @Published var seconds:TimeInterval=0
    @Published var isRunning: Bool = false
    @Published var mode:Mode = .start
    @Published var lapTimes:[LapTimes]=[]
    var lastTime:TimeInterval=0
    private var pausedTime: TimeInterval = 0
    
    var timer=Timer()
    var lastLap:TimeInterval=0
    
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
            self.lapTimes=[]
            lastLap=0
        case .lap:
            self.recordLaps()
        }
    }
    
    func recordLaps(){
        let lapTime=seconds-lastLap
        let formattedLapTime=formatElapsedTime(lapTime)
        let newLap=LapTimes(lapTimes: formattedLapTime)
        lapTimes.append(newLap)
        lastLap=seconds
    }
    func formattedString()->String{
        let minutes = Int(seconds) / 60 % 60
        let sec = Int(seconds) % 60
        let milliseconds = Int((Double(seconds * 100)).truncatingRemainder(dividingBy: 100))
        
        // Return the formatted time
        return String(format: "%02d:%02d:%02d", minutes, sec, milliseconds)
    }
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
