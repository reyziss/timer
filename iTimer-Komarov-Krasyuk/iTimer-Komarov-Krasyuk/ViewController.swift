//
//  ViewController.swift
//  iTimer-Komarov-Krasyuk
//
//  Created by Student on 06.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var lapTable: [String] = []
    
    @IBAction func lapResetButtonTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            
        }
        else
        {
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(minutes: 0, seconds: 0)
        }
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any)
    {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
        }
        else
        {
            timerCounting = true
            startStopButton.setTitle("Pause", for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter () -> Void
    {
        count = count + 1
        let time = secondsToMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return (((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int) -> String
    {   var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @IBAction func lapAdd(_ sender: UIButton) {
        if(timerCounting)
        {
            lapTable.append(timerLabel.text!)
            table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = lapTable[indexPath.row]
        return cell
    }
}
