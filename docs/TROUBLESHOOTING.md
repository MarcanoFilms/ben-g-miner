# Troubleshooting Guide

## Common Issues

### "Socket closed waiting in recv_line"

**Problem**: Connection to DATUM gateway drops immediately after connecting.

**Solution**:
```bash
# Check if DATUM is running
docker ps | grep datum-gateway

# Verify port is listening
lsof -i :23334

# Check DATUM logs
docker logs datum-gateway | tail -20
```

### "GPU not detected" / "CL_DEVICE_NOT_FOUND"

**Problem**: bfgminer can't find GPU even though nvidia-smi shows it.

**Solution**:
```bash
# 1. Install opencl-nvidia (must be BEFORE building bfgminer)
sudo pacman -S opencl-nvidia

# 2. Verify OpenCL setup
clinfo | grep -i nvidia

# 3. Fix GPU permissions
sudo tee /etc/udev/rules.d/70-nvidia-gpu.rules > /dev/null << RULES
KERNEL=="nvidia-uvm", MODE="0666"
KERNEL=="nvidia-uvm-tools", MODE="0666"
RULES

sudo udevadm control --reload-rules
sudo udevadm trigger
```

### "No servers could be used"

**Problem**: Pool can't be reached or wallet is invalid.

**Solutions**:
1. Verify Bitcoin address format: `bc1q...` (bech32)
2. Check DATUM is running: `docker ps | grep datum`
3. Verify port: `lsof -i :23334`
4. Check config: `cat ~/.ben-g-miner/ben-g-miner.conf`

### GPU Temperature > 85°C

**Problem**: GPU is overheating.

**Solutions**:
- Lower intensity: `"intensity": "11"` (was 13)
- Increase fan speed: `nvidia-smi -lgc 90`
- Improve case airflow: add case fans or open side panel
- Reduce room temperature

### 0 shares accepted after 24 hours

**This is NORMAL**. GPU hashrate is too low for DATUM's share difficulty (~131,072). Shares are expected to take 1-2 weeks to appear, if ever.

### Service won't start

**Check logs**:
```bash
systemctl --user status ben-g-miner.service
journalctl --user -u ben-g-miner.service -n 20
```

**Common causes**:
- bfgminer not installed: `which bfgminer`
- Config file invalid: `cat ~/.ben-g-miner/ben-g-miner.conf`
- Port 4028 already in use: `lsof -i :4028`

### High CPU usage

bfgminer's CPU usage is normal (10-15% for GPU mining). If it's much higher:
- Disable ncurses: add `"text-only": true` to config
- Disable API: remove `api-listen` flag
- Reduce logging: remove `--debug` flag

---

## Getting Help

1. Check logs: `journalctl --user -u ben-g-miner.service -f`
2. Verify prerequisites: Bitcoin Knots, DATUM, GPU drivers
3. Test GPU: `nvidia-smi` and `clinfo`
4. Open an issue on GitHub with:
   - GPU model
   - OS and driver version
   - Full error message
   - Relevant log output

