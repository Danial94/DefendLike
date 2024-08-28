//
//  ZDefendManager.swift
//  DefendLike
//
//  Created by Danial Tan on 22/07/2024.
//

import Foundation
import ZDefend

class ZDefendManager: ObservableObject {
    private var deviceStatusRegistration: ZDeviceStatusRegistration?
    private var lastDeviceStatus: ZDeviceStatus?
    private var registeredFunctions = [ZLinkedFunctionRegistrationV2]()
    
    static let shared = ZDefendManager()
    
    @Published var threats: [ThreatModel] = []
    @Published var policies: [PolicyModel] = []
    @Published var linkedObjects: [LinkedModel] = []
    @Published var functionLabels: [String] = []
    @Published var troubleshootLogs: String = ""
    @Published var troubleshootDetails: String = ""
    @Published var auditLogs: String = ""
    @Published var isLoaded: Bool = false
    
    func initializeZDefend() {
        deviceStatusRegistration = ZDefend.addDeviceStatusCallback(onDeviceStatus(_:))
        self.auditLogs.append("ZDefendManager - initializeZDefend()\n")
    }
    
    func deregisterZDefend() {
        deviceStatusRegistration?.deregister()
        deviceStatusRegistration = nil
        self.auditLogs.append("ZDefendManager - deregisterZDefend()\n")
    }
    
    func checkForUpdates() {
        ZDefend.checkForUpdates()
        self.auditLogs.append("ZDefendManager - checkForUpdates()\n")
    }
    
    func getThreats() {
        let threats = lastDeviceStatus != nil ? lastDeviceStatus?.allThreats : []
        
        self.threats = []
        for threat in (threats ?? []) {
            if (self.threats.contains(where: { item in item.id == threat.uuid })) {
                continue
            }
            
            self.threats.append(ThreatModel(
                id: threat.uuid,
                name: threat.localizedName,
                severity: threat.nameForSeverity,
                status: threat.isMitigated,
                description: threat.localizedDetails,
                resolution: threat.localizedResolution
            ))
        }
        
        self.auditLogs.append("ZDefendManager - getThreats()\n")
    }
    
    func getPolicies() {
        let policies = lastDeviceStatus != nil ? lastDeviceStatus?.devicePolicies : []
        
        self.policies = []
        for policy in (policies ?? []) {
            if (self.policies.contains(where: { item in item.id == policy.policyHash })) {
                continue
            }
            
            self.policies.append(PolicyModel(id: policy.policyHash, description: policy.debugDescription()))
        }
        
        self.auditLogs.append("ZDefendManager - getPolicies()\n")
    }
    
    func getLogs() {
        ZDefendTroubleshoot.getZLog { log in
            DispatchQueue.main.async { [weak self] in
                self?.troubleshootLogs += "ZlogCallback->\n\(log)"
            }
        }
        
        self.auditLogs.append("ZDefendManager - getLogs()\n")
    }
    
    func getLogDetails() {
        ZDefendTroubleshoot.getDetails { details in
            var message = "ZTroubleshotDetailsCallback:"
            details.forEach { (key: String, value: NSObject) in
                var string = value.debugDescription
                if string.count > 250 {
                    string = String(string[...String.Index(utf16Offset: 20, in: string)]) + "..."
                }
                
                message += "\n    \(key) : \(string)"
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.troubleshootDetails += message
            }
        }
        
        self.auditLogs.append("ZDefendManager - getLogDetails()\n")
    }
    
    func onThreatMitigated() {
        ZDefendDeveloper.mitigateSimulatedThreats()
        self.auditLogs.append("ZDefendManager - onThreatMitigated()\n")
    }
    
    func runSimulatedThreat(id: Int32) {
        var forensics = [String:Any]();
        
        switch (id) {
        case 13: // MALWARE
            forensics["Application"] = "com.montimage.eicar_virus"
            forensics["Process"] = "Testing Malware (EICAR virus)"
            
        case 24: // UNTRUSTED_PROFILE
            forensics["server_untrusted_profile_detail"] = ["profile_name":"simulated_untrusted_profile"]
            
        case 45: // SUSPICIOUS_PROFILE
            forensics["server_suspicious_profile_detail"] = ["profile_name":"simulated_suspicious_profile"]
            
        case 42: // SUSPICIOUS_APP
            forensics["server_suspicious_ipa_detail"] = ["app_name":"Net Analyzer","filename":"Net Analyzer","is_blacklisted":true,"is_malicious":false,"package":"com.example.net_analyzer"]
            
        case 93: // OUT_OF_COMPLIANCE_APP
            forensics["server_ooc_detail"] = ["app_name":"simulated_ooc_app_name","package":"com.example.simulated_ooc_app_name"]
            
        default: // NOTHING
            break
        }
        
        ZDefendDeveloper.simulateTestThreat(id, forensics: forensics)
        self.auditLogs.append("ZDefendManager - runSimulateThreat(\(id))\n")
    }
    
    func onDeviceStatus(_ status: ZDeviceStatus) {
        var message = "onDeviceStatus -> \(status.nameForLoginStatus)"
        if (status.loginStatus == ZLoginStatus.LOGGED_IN) {
            message += "\nscan progress %: \(status.initialScanProgressPercentage)"
            self.isLoaded = true
        } else {
            message += "\nlast login error: \(status.nameForLoginLastError)"
        }
        
        lastDeviceStatus = status
        self.auditLogs.append("ZDefendManager - onDeviceStatus: (\(status.nameForLoginStatus))\n")
        NSLog(message)
    }
    
    func registerLinkedFunction(input: String) {
        if (!input.isEmpty) {
            registeredFunctions.append(ZDefend.registerLinkedFunction(
                input, function: onLinkedFunction(event:), mitigateFunction: onMitigateFunction(event:)
            ))
            self.linkedObjects.append(LinkedModel(
                id: input,
                label: input,
                description: "",
                eventType: "",
                threats: []
            ))
        }
        
        self.auditLogs.append("ZDefendManager - registerLinkedFunction(\(input))\n")
    }
    
    func deregisterAllLinkedFunctions() {
        registeredFunctions.forEach { registration in
            registration.deregister()
        }

        registeredFunctions.removeAll()
        self.linkedObjects.removeAll()
        self.auditLogs.append("ZDefendManager - deregisterAllLinkedFunctions()\n")
    }
    
    func onLinkedFunction(event: ZLinkedFunctionEvent) {
        var threats: [ThreatModel] = []
        event.relatedThreats.forEach { threat in
            threats.append(ThreatModel(
                id: threat.uuid,
                name: threat.localizedName,
                severity: threat.nameForSeverity,
                status: threat.isMitigated,
                description: threat.localizedDetails,
                resolution: threat.localizedResolution
            ))
        }
        
        let linked = self.linkedObjects.first(where: { $0.id == event.label })
        linked?.description = event.debugDescription
        linked?.eventType = event.eventType == .ACTIVATED_LINKED_FUNCTION ? "ACTIVATED" : "MITIGATED"
        linked?.threats = threats
        
        self.auditLogs.append("ZDefendManager - onLinkedFunction(\(event.label))\n")
    }
    
    func onMitigateFunction(event: ZLinkedFunctionEvent) {
        self.auditLogs.append("ZDefendManager - onMitigateFunction(\(event.label))\n")
    }
}
