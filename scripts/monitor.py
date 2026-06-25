#!/usr/bin/env python3

import socket
import json
import sys

def get_bfgminer_stats():
    """Query bfgminer API for mining statistics"""
    try:
        s = socket.socket()
        s.connect(('127.0.0.1', 4028))
        s.send(b'{"command":"summary"}')
        data = s.recv(8192).decode(errors='ignore').rstrip('\x00')
        s.close()
        
        d = json.loads(data)
        su = d['SUMMARY'][0]
        
        uptime_h = su['Elapsed'] // 3600
        uptime_m = (su['Elapsed'] % 3600) // 60
        
        print("\n" + "="*50)
        print("   Ben-G Miner Status")
        print("="*50)
        print(f"Hashrate (avg):  {su['MHS av']:.1f} MH/s ({su['MHS av']/1000:.2f} GH/s)")
        print(f"Hashrate (20s):  {su.get('MHS 20s', 0):.1f} MH/s")
        print(f"Uptime:          {uptime_h}h {uptime_m}m")
        print(f"Accepted:        {su['Accepted']} shares")
        print(f"Rejected:        {su['Rejected']} shares")
        print(f"HW Errors:       {su['Hardware Errors']}")
        print(f"Best Share:      {su['Best Share']:.2f}")
        print(f"Network Blocks:  {su['Network Blocks']}")
        print("="*50 + "\n")
        
    except Exception as e:
        print(f"Error: Could not connect to bfgminer API on port 4028")
        print(f"Is the miner running? Start with: systemctl --user start ben-g-miner.service")
        sys.exit(1)

if __name__ == "__main__":
    get_bfgminer_stats()
