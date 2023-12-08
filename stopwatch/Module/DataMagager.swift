////
////  DataMagager.swift
////  stopwatch
////
////  Created by Apple on 07/12/23.
////
//
//import Foundation
//import CoreData
//class DataMagager:ObservableObject{
//    let container: NSPersistentContainer
//    static let shared=DataMagager()
//    init(){
//        container=NSPersistentContainer(name: "LapRecordTable")
//        container.loadPersistentStores{des, err in
//            if let err{
//                print(err.localizedDescription,"unable to initilaize core data")
//            }
//        }
//    }
//}
