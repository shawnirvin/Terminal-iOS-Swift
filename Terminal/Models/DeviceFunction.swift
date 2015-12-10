//
//  DeviceFunction.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/9/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

class DeviceFunction: Function, Helpful {
    lazy var currentDevice: UIDevice = {
        return UIDevice.currentDevice()
    }()
    
    init() {
        super.init(identifier: "^device (name|osversion|battery|info)", name: "device")
    }
    
    override func execute(command: Command, completion: (response: String?) -> Void) {
        let term = command.elements[1]
        var output: String?
        
        if term == "name" {
            output = deviceName()
        }
        else if term == "osversion" {
            output = osInfo()
        }
        else if term == "battery" {
            output = batteryInfo()
        }
        else if term == "info" {
            output = deviceName() + "\n\t" +
                        osInfo() + "\n\t" +
                        batteryInfo()
        }
        
        completion(response: output)
    }
    
    func deviceName() -> String {
        return self.currentDevice.name
    }
    
    func osInfo() -> String {
        return self.currentDevice.systemName + " " + self.currentDevice.systemVersion
    }
    
    func batteryInfo() -> String {
        var output = ""
        
        self.currentDevice.batteryMonitoringEnabled = true
        
        if self.currentDevice.batteryState == .Charging {
            output = "Charging"
        }
        else if self.currentDevice.batteryState == .Full {
            output = "Full"
        }
        else if self.currentDevice.batteryState == .Unplugged {
            output = "Unplugged"
        }
        else if self.currentDevice.batteryState == .Unknown {
            output = "Battery Status Unknown"
        }
        
        if self.currentDevice.batteryState != .Unknown {
            let batteryPercentage = self.currentDevice.batteryLevel * 100
            
            output = output + " - " + batteryPercentage.description + "%"
        }
        
        return output
    }
    
    func help() -> String {
        let help = "\tname\t\t\tGet the name" +
                    "\t\tosversion\t\tGet the OS type and version" +
                    "\t\tbattery\t\t\tGet the battery status" +
                    "\t\tinfo\t\t\tGet all available device info"
        
        return help
    }
}
