//
//  StopWatchView.swift
//  stopwatch
//
//  Created by Kashif on 06/12/23.
//

import SwiftUI
import CoreData

struct StopWatchView: View {
    @ObservedObject var viewModel=StopWatchViewModel()
    var body: some View {
        VStack{
            Text("\(viewModel.formattedString())")
                .font(.system(size: 36))
                .blockStyle()
                .padding(.top,20)
            
            HStack{
                VStack{
                    SaveLap(imageName: "stop.fill"){
                        viewModel.startStopwatch(mode: .reset)
                    }
                    Text("Reset")
                        .font(.system(size: 10))
                        .padding(.top,5)
                }
                VStack{
                    PlayButton(imageName: viewModel.mode == .start ? "play.fill" : "pause.fill"){
                        if viewModel.mode == .start{
                            viewModel.startStopwatch(mode: .start)
                        } else{
                            viewModel.startStopwatch(mode: .pause)
                        }
                    }
                    Text("Start/Pause")
                        .font(.system(size: 10))
                        .padding(.top,5)
                }
                VStack{
                    SaveLap(imageName: "flag", isDisabled: viewModel.mode == .start ? .start : .pause){
                        viewModel.saveLap()
                    }
                    Text("Lap")
                        .font(.system(size: 10))
                        .padding(.top,5)
                }
            }.padding(.top,30)
            List(viewModel.lapTimes, id:\.self){item in
                Text((item.lapTime ?? "")+" s")
                    .foregroundColor(.blue)
            }
        }.padding([.leading,.trailing],20)
    }
}

//#Preview {
//    StopWatchView()
//}

struct PlayButton:View{
    var imageName:String
    var onTap:(()-> Void)?
    init(imageName: String, onTap: (() -> Void)? = nil) {
        self.imageName = imageName
        self.onTap = onTap
    }
    var body: some View{
        Button{
        } label:{
            Image(systemName: imageName)
                .foregroundColor(.white)
                .onTapGesture{
                    onTap?()
                }
        }
        .padding(25)
        .background(Color(hex:0x0515f2))
        .opacity(0.9)
        .clipShape(Circle())
        .onTapGesture {
            onTap?()
        }
        
        
    }
}

struct SaveLap:View{
    var imageName:String
    var isDisabled:Mode?=nil
    var onTap:(()-> Void)?
    var body: some View{
        Button{
        } label:{
            Image(systemName: imageName)
                .foregroundColor((isDisabled == .start) ? .black : .white)
                .onTapGesture{
                    onTap?()
                }
                .disabled((isDisabled == .start) ? true : false)
        }
        .padding(20)
        .background(Color(hex:0xE9E4E3))
        .opacity(0.9)
        .clipShape(Circle())
        .onTapGesture {
            onTap?()
        }
        .disabled((isDisabled == .start) ? true : false)
    }
}

