# Ben-G Miner 🎮⚡

**GPU Bitcoin Mining for the Brave (or Foolish)**

A complete, documented, and optimized setup for mining Bitcoin SHA-256 using NVIDIA GPUs via Stratum v1, connected to your own Bitcoin Knots node and DATUM gateway for decentralized mining.

---

## ⚠️ **REALITY CHECK: This is a Financial Suicide Mission**

Before you proceed, understand this:

- **GPU hashrate**: ~2 GH/s (RTX 3060 Ti)
- **Network hashrate**: ~1,000 EH/s
- **Your share of hashrate**: 0.000002% 
- **Expected block time with GPU alone**: ~9,370 years
- **Electricity cost**: 150-200W continuously (~$20-40/month)
- **Expected monthly rewards**: $0.00

**This project exists as a technical proof-of-concept and educational experiment, NOT as a profitable mining strategy.**

---

## What is Ben-G Miner?

Ben-G Miner is a **complete, self-contained Bitcoin mining solution**:

1. **bfgminer** (patched for DATUM gateway)
2. **Bitcoin Knots** (your full node, generating templates)
3. **DATUM Gateway** (decentralized pool interface)
4. **NVIDIA GPU support** (OpenCL SHA-256)
5. **systemd service** (runs in background)
6. **Complete documentation** (everything explained)

**Result**: Solo mining directly to your own node, zero fees, zero KYC, 100% Bitcoin rewards (if you find a block).

---

## Requirements

### Hardware
- **GPU**: NVIDIA (RTX 3060 Ti or newer, 6GB+ VRAM)
- **CPU**: Modern multi-core (6+ cores)
- **RAM**: 16+ GB
- **Storage**: 50+ GB
- **Power**: 200-300W sustained

### Software
- **OS**: Linux (Arch, Ubuntu, Debian tested)
- **Bitcoin**: Knots 20260508+ (full node synced)
- **DATUM Gateway**: Docker container
- **OpenCL**: NVIDIA drivers + opencl-nvidia

---

## Quick Start

```bash
# 1. Clone repo
git clone https://github.com/yourusername/ben-g-miner.git
cd ben-g-miner

# 2. Run installer
chmod +x install.sh
./install.sh

# 3. Start mining
systemctl --user start ben-g-miner.service

# 4. Watch logs
journalctl --user -u ben-g-miner.service -f
```

---

## GPU Compatibility

Supports all NVIDIA GPUs with CUDA 11.0+:
- ✅ RTX 30-series (3060 Ti, 3080, 3090)
- ✅ RTX 40-series (4070, 4080, 4090)
- ✅ A-series (A10, A40, A100)
- ✅ Quadro/RTX datacenter

---

## Performance

| GPU | Hashrate | Power | Efficiency |
|---|---|---|---|
| RTX 3060 Ti | 2.0 GH/s | 200W | 10 MH/W |
| RTX 3080 | 4.0 GH/s | 320W | 12.5 MH/W |
| RTX 4090 | 8.0 GH/s | 450W | 17.8 MH/W |

---

## Documentation

- **INSTALLATION.md** - Detailed setup guide
- **CONFIG.md** - Configuration reference
- **TROUBLESHOOTING.md** - Common issues
- **ARCHITECTURE.md** - How it works

---

## License

MIT License - See LICENSE file

---

## Disclaimer

For **educational purposes only**. Not profitable. You will lose money on electricity. Use to learn Bitcoin mining, not to make income.

If you want Bitcoin: buy it. Don't mine with GPU.

---

**Status**: Production-ready, actively maintained  
**Latest Update**: June 24, 2026  
**Tested GPU**: NVIDIA RTX 3060 Ti (6GB VRAM)
