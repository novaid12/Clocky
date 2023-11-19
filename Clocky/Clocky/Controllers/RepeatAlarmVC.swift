//
//  RepeatAlarmVC.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import UIKit
import SnapKit

class RepeatAlarmVC: UIViewController {
    var selectDays: Set<Day> = []
    
    // MARK: - UI

    let tableView: UITableView = {
        let myTable = UITableView(frame: CGRect.zero, style: .insetGrouped)
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.tintColor = .orange
        return myTable
    }()
    
    weak var repeatDelegate: UpdateRepeatLabelDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
        repeatDelegate?.updateRepeatLabel(selectedDay: selectDays)
    }
    
    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
    }
    
    func setupUI() {
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backBarButtonItem?.title = "Back"
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RepeatAlarmVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Day.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let day = Day.allCases[indexPath.row]
        let isSelected = selectDays.contains(day)
        cell.textLabel?.text = day.dayString
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = Day.allCases[indexPath.row]
        if selectDays.contains(day) {
            selectDays.remove(day)
        } else {
            selectDays.insert(day)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
