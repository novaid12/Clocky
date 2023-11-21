//
//  AlarmVC.swift
//  Clocky
//
//  Created by  NovA on 18.11.23.
//

import SnapKit
import UIKit

class AlarmVC: UIViewController {
    var alarmStore = AlarmStore() {
        didSet {
            alarmTableView.reloadData()
        }
    }

    // MARK: - UI

    let alarmTableView: UITableView = {
        let myTable = UITableView(frame: .zero, style: .grouped)
        myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "other")
        return myTable
    }()

    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        alarmTableView.dataSource = self
        alarmTableView.delegate = self
        setupNavigation()
        setViews()
        setLayouts()
    }

    // MARK: - setViews

    func setViews() {
        view.addSubview(alarmTableView)
    }

    // MARK: - setLayouts

    func setLayouts() {
        alarmTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        alarmTableView.backgroundColor = .black
    }

    // MARK: - setup Navegation

    func setupNavigation() {
        navigationItem.title = "Alarm"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        editButtonItem.tintColor = .orange
        navigationController?.navigationBar.barTintColor = .black

    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        alarmTableView.setEditing(editing, animated: true)
    }

    @objc func addAlarm() {
        alarmStore.isEdit = false
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
    }
}

// MARK: - tableView

extension AlarmVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmStore.alarms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath) as? AlarmOtherTableViewCell else { return UITableViewCell() }
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sleep | Wake Up"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        header.textLabel?.textColor = .white
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarmStore.remove(indexPath.row)
        }
    }
}

extension AlarmVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
}

// MARK: - saveAlarm

extension AlarmVC: SaveAlarmInfoDelegate {
    func saveAlarmInfo(alarmData: AlarmInfo, index: Int) {
        if alarmStore.isEdit == false {
            alarmStore.append(alarmData)
        } else {
            alarmStore.edit(alarmData, index)
        }
    }
}
