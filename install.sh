#!/bin/bash
set -e

echo "========================================="
echo "  Ben-G Miner - Installation Script"
echo "========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check prerequisites
echo -e "${YELLOW}[1/5] Checking prerequisites...${NC}"

if ! command -v bitcoin-cli &> /dev/null; then
    echo -e "${RED}ERROR: bitcoin-cli not found. Bitcoin Knots must be installed.${NC}"
    exit 1
fi

if ! command -v nvidia-smi &> /dev/null; then
    echo -e "${RED}ERROR: nvidia-smi not found. NVIDIA drivers not installed.${NC}"
    exit 1
fi

if ! command -v clinfo &> /dev/null; then
    echo -e "${RED}ERROR: clinfo not found. Install opencl-nvidia package.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites OK${NC}"
echo ""

# Verify Bitcoin Knots
echo -e "${YELLOW}[2/5] Verifying Bitcoin Knots...${NC}"
if bitcoin-cli getblockchaininfo > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Bitcoin Knots is running${NC}"
else
    echo -e "${RED}ERROR: Bitcoin Knots not responding. Start it first.${NC}"
    exit 1
fi
echo ""

# Create config directory
echo -e "${YELLOW}[3/5] Creating config directory...${NC}"
mkdir -p ~/.ben-g-miner
cp config/ben-g-miner.conf ~/.ben-g-miner/
echo -e "${GREEN}✓ Config directory created at ~/.ben-g-miner${NC}"
echo ""

# Update config with user's address
echo -e "${YELLOW}[4/5] Configuration${NC}"
read -p "Enter your Bitcoin address (bech32 format, starts with bc1q): " BTC_ADDR

if [[ ! $BTC_ADDR =~ ^bc1q[a-z0-9]{39}$ ]]; then
    echo -e "${RED}ERROR: Invalid Bitcoin address format${NC}"
    exit 1
fi

sed -i "s/bc1qYOUR_BITCOIN_ADDRESS/$BTC_ADDR/g" ~/.ben-g-miner/ben-g-miner.conf

read -p "Enter GPU intensity (8-18, default 13): " INTENSITY
INTENSITY=${INTENSITY:-13}

sed -i "s/\"intensity\": \"13\"/\"intensity\": \"$INTENSITY\"/g" ~/.ben-g-miner/ben-g-miner.conf

echo -e "${GREEN}✓ Configuration updated${NC}"
echo "  Address: $BTC_ADDR"
echo "  Intensity: $INTENSITY"
echo ""

# Install systemd service
echo -e "${YELLOW}[5/5] Installing systemd service...${NC}"
mkdir -p ~/.config/systemd/user
cp systemd/ben-g-miner.service ~/.config/systemd/user/

# Update service file with user's address
sed -i "s/bc1qYOUR_ADDRESS/$BTC_ADDR/g" ~/.config/systemd/user/ben-g-miner.service

systemctl --user daemon-reload
systemctl --user enable ben-g-miner.service

echo -e "${GREEN}✓ Systemd service installed${NC}"
echo ""

echo "========================================="
echo -e "${GREEN}Installation Complete!${NC}"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Start mining: systemctl --user start ben-g-miner.service"
echo "  2. Check status: systemctl --user status ben-g-miner.service"
echo "  3. View logs: journalctl --user -u ben-g-miner.service -f"
echo ""
echo "Config location: ~/.ben-g-miner/ben-g-miner.conf"
echo "Service location: ~/.config/systemd/user/ben-g-miner.service"
echo ""
