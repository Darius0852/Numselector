//
//  ViewController.swift
//  Numselector
//
//  Created by darius ghomashchian on 27/11/2019.
//  Copyright © 2019 darius ghomashchian. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    var centralManager: CBCentralManager!
    
    var bluetoothMod: CBPeripheral?
    private var ledChar: CBCharacteristic?
    
    let serviceUUID = CBUUID(string: "FFE0")
    let blueCharacteristicUUID = CBUUID(string: "FFE1")
    
    @IBOutlet weak var connectionLabel: UILabel!
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func settings(_ sender: Any) {
        
    }
    

    @IBAction func one(_ sender: Any) {
        textField.text = "1"
    }
    
    @IBAction func two(_ sender: Any) {
        textField.text = "2"
    }
    
    @IBAction func three(_ sender: Any) {
        textField.text = "3"
    }
    
    @IBAction func four(_ sender: Any) {
        textField.text = "4"
    }
    
    @IBAction func five(_ sender: Any) {
        textField.text = "5"
    }
    
    @IBAction func six(_ sender: Any) {
        textField.text = "6"
    }
    
    @IBAction func seven(_ sender: Any) {
        textField.text = "7"
    }
    
    @IBAction func eight(_ sender: Any) {
        textField.text = "8"
    }
    
    @IBAction func nine(_ sender: Any) {
        textField.text = "9"
    }
    
    @IBAction func go(_ sender: Any) {
        
        let value: String = textField.text ?? ""
        let data = Data(bytes: value, count: 1)
        
        if ledChar != nil {
            if let connectingPeripheral = bluetoothMod {
                connectingPeripheral.writeValue(data as Data, for: ledChar!, type: CBCharacteristicWriteType.withoutResponse)
            }
        } else {
            connectionLabel.text = "Not connected"
        }
        
        //sleep to crate delay between prize result and LED command
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
        }
        
        //next check if random number is correct
        let number = Int.random(in: 1 ..< 10)
        print("random num = " + String(number))
        let resultData = String(number)
        
        // if a match send 'a' via serial com to trigger prize motor on arduino
        if (resultData == value) {
            let value2: String = "a"
            let data2 = Data(bytes: value2, count: 1)
            if let connectingPeripheral = bluetoothMod {
                connectingPeripheral.writeValue(data2 as Data, for: ledChar!, type: CBCharacteristicWriteType.withoutResponse)
            }
            //tell user number matched with app alert
            let alert = UIAlertController(title: "Congrats", message: "You matched the random number", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let value3: String = "b"
            let data3 = Data(bytes: value3, count: 1)
            if let connectingPeripheral = bluetoothMod {
                connectingPeripheral.writeValue(data3 as Data, for: ledChar!, type: CBCharacteristicWriteType.withoutResponse)
            }
            // create the alert
            let alert = UIAlertController(title: "Unlucky", message: "You didnt match the random number", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManager = CBCentralManager()
        centralManager.delegate = self
    }
    
    //MARK: - Central manager delegate
    
    //keep track of state of bluetooth chip (is it powered on ect..)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        centralManager.stopScan()
        bluetoothMod = peripheral
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
        connectionLabel.text = "Connected"
    }

    
    //MARK: - Peripheral delegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let service = peripheral.services?.first(where: { $0.uuid == serviceUUID }) {
            peripheral.discoverCharacteristics([blueCharacteristicUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //first check if has bluetooth service (service UUID) that we are looking for
        if let characteristic = service.characteristics?.first(where: { $0.uuid == blueCharacteristicUUID}) {
            //set notify value to true so if bluetooth mod pushes data, we listen for that
            peripheral.setNotifyValue(true, for: characteristic)
            
            ledChar = characteristic
         
        }
        
    }
    
    //didupdatevaluefor is called every time we get a new value for the device, what we do then
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            let result: Int = data.withUnsafeBytes{ $0.pointee } >> 8 & 0xFFFFFF
            //connectionLabel.text = String(result)
        
            
        }
    }


}

