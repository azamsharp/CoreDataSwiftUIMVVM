//
//  ContentView.swift
//  CoreDataMVVM
//
//  Created by Mohammad Azam on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskListVM = TaskListViewModel()
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskListVM.tasks[index]
            taskListVM.delete(task)
        }
        
        taskListVM.getAllTasks()
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter task name", text: $taskListVM.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    taskListVM.save()
                    taskListVM.getAllTasks()
                }
            }
            
            List {
                ForEach(taskListVM.tasks, id: \.id) { task in
                    Text(task.title)
                }.onDelete(perform: deleteTask)
            }
            
            Spacer()
        }.padding()
        .onAppear(perform: {
            taskListVM.getAllTasks()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
