//
//  AddTaskViewController.swift
//  HelloRxSwift
//
//  Created by Ezequiel Barreto on 10/06/21.
//  Copyright © 2021 Ezequiel Barreto. All rights reserved.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObserver()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else {
            return
        }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.navigationController?.popViewController(animated: true)
    }
}
