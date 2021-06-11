//
//  TestListViewController.swift
//  HelloRxSwift
//
//  Created by Ezequiel Barreto on 09/06/21.
//  Copyright © 2021 Ezequiel Barreto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestListViewController: UIViewController {
    @IBOutlet weak var prioriySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks:  [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}

extension TestListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addTVC = segue.destination as? AddTaskViewController else {
            fatalError("Controller not found")
        }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext: { task in
                let priority = Priority(rawValue: self.prioriySegmentedControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                self.filterTasks(by: priority)
            }).disposed(by: disposeBag)
    }
    
    private func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            updateTableView()
            return
        }
        
        self.tasks.map { tasks in
            return tasks.filter { $0.priority == priority! }
        }.subscribe(onNext: { [weak self] tasks in
            self?.filteredTasks = tasks
            self?.updateTableView()
        }).disposed(by: disposeBag)
    }
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
}

extension TestListViewController: UITableViewDelegate {
    
}

extension TestListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    
}
