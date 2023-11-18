//
//  AlarmTVC.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import UIKit

class AlarmTVC: UITableViewController {
    var alarmStore = AlarmStore() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - UI

//    let alarmTableView: UITableView = {
//        let myTable = UITableView(frame: .zero, style: .grouped)
    ////        myTable.separatorStyle = .singleLine
    ////        myTable.register(WakeUpTableViewCell.self, forCellReuseIdentifier: "wakeup")
//        myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "Cell")
//        return myTable
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "Cell")
        setupNavigation()
    }
    
    override func viewWillLayoutSubviews() {
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmStore.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlarmOtherTableViewCell
        let alarm = alarmStore.alarms[indexPath.row]
        cell.textLabel?.text = alarm.date.toString(format: "HH:mm")
        cell.detailTextLabel?.text = alarm.noteLabel
        cell.lightSwitch.isOn = alarm.isOn
        cell.textLabel?.textColor = alarm.isOn ? .white : .darkGray
        cell.detailTextLabel?.textColor = alarm.isOn ? .white : .darkGray
        cell.callBackSwitchState = { isOn in
            self.alarmStore.isSwitch(indexPath.row, isOn)
        }
       
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sleep | Wake Up"
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        header.textLabel?.textColor = .white
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmStore.remove(indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmStore.isEdit = true
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let alarm = alarmStore.alarms[indexPath.row]
        vc.alarm = alarm
        vc.tempIndexRow = indexPath.row
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func setupNavigation() {
        navigationItem.title = "Alarm"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        editButtonItem.tintColor = .orange
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }

    @objc func addAlarm() {
        alarmStore.isEdit = false
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
    }
}

extension AlarmTVC: SaveAlarmInfoDelegate {
    func saveAlarmInfo(alarmData: AlarmInfo, index: Int) {
        if alarmStore.isEdit == false {
            alarmStore.append(alarmData)
        } else {
            alarmStore.edit(alarmData, index)
        }
    }
}
