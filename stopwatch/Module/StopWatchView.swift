//
//  StopWatchView.swift
//  stopwatch
//
//  Created by Apple on 06/12/23.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject var viewModel=StopWatchViewModel()
    var body: some View {
        VStack{
            Text("\(viewModel.formattedString())")
                .font(.system(size: 36))
            //            HStack{
            //                VStack(alignment: .center, spacing: 8) {
            //                    Text("00")
            //                        .font(.system(size: 36))
            //                        .multilineTextAlignment(.center)
            //                }
            //                .blockStyle()
            //                Text(":")
            //                    .font(.system(size: 36))
            //                VStack(alignment: .center, spacing: 8) {
            //                    Text("00")
            //                        .font(.system(size: 36))
            //                        .multilineTextAlignment(.center)
            //                }
            //                .blockStyle()
            //                Text(":")
            //                    .font(.system(size: 36))
            //                VStack(alignment: .center, spacing: 8) {
            //                    Text("00")
            //                        .font(.system(size: 36))
            //                        .multilineTextAlignment(.center)
            //                }
            //                .blockStyle()
            //            }
            
            HStack{
                SaveLap(imageName: "stop.fill"){
                    viewModel.startStopwatch(mode: .reset)
                }
                PlayButton(imageName: viewModel.mode == .start ? "play.fill" : "pause.fill"){
                    if viewModel.mode == .start{
                        viewModel.startStopwatch(mode: .start)
                    } else{
                        viewModel.startStopwatch(mode: .pause)
                    }
                }
                
                SaveLap(imageName: "flag", isDisabled: viewModel.mode == .start ? .start : .pause){
                    viewModel.startStopwatch(mode: .lap)
                }
            }.padding(.top,50)
                List(viewModel.lapTimes){item in
                    Text(item.lapTimes)
                        .foregroundColor(.blue)
                }
                .background(.clear)
            
            
            
            
            
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
//E9E4E3
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

