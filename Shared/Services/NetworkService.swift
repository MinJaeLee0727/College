//
//  NetworkService.swift
//  college
//
//  Created by Min Jae Lee on 2021/05/04.
//

import Foundation
import Network

final class NetworkService {
    static let shared = NetworkService()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType? = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {
            [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    public func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
