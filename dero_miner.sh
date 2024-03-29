#!/data/data/com.termux/files/usr/bin/bash


WALLET=""
POOL_ADDRESS=""
source config.conf
CPU_THREADS=$(nproc)
HANSEN_DOWNLOAD_LINK="https://github.com/Hansen333/Hansen33-s-DERO-Miner/releases/download/Version-0.6/hansen33s-dero-miner-android-arm64.tar.gz"
DERO_CLI_MINER_LINK="https://github.com/deroproject/derohe/releases/download/Release140/dero_linux_arm7.tar.gz"

if [[ $(uname -m) =~ 64 ]]; then
    PLATFORM="arm64"
else 
    PLATFORM="arm32"    
fi

termux-wake-lock
pkg update && pkg upgrade -y
pkg install golang wget curl git tmux -y

if [ $PLATFORM == "arm64" ]; then
    WORKERS=$((CPU_THREADS / 2))
    wget $HANSEN_DOWNLOAD_LINK
    tar -xvf hansen33*.tar.gz
    rm hansen33*.tar.gz
    chmod +x hansen33*
    echo "#!/data/data/com.termux/files/usr/bin/bash" >> start_miner.sh
    echo " " >> start_miner.sh
    echo "$(pwd)/hansen33* --wallet-address $WALLET --mining-threads 2 --workers $WORKERS --daemon-rpc-address $POOL_ADDRESS --turbo" >> start_miner.sh
    chmod +x start_miner.sh
    MINING_SCRIPT="$(pwd)/start_miner.sh"
    echo "tmux new-session \"bash $MINING_SCRIPT\"" >> $HOME/.bashrc
    tmux new-session "bash $MINING_SCRIPT"
else 
    wget $DERO_CLI_MINER_LINK
    tar -xvf dero_linux*.tar.gz
    rm dero_linux*.tar.gz
    cd dero_linux_arm7
    chmod +x dero-miner*
    echo "#!/data/data/com.termux/files/usr/bin/bash" >> start_miner.sh
    echo " " >> start_miner.sh
    echo "$(pwd)/dero-miner* --wallet-address $WALLET --daemon-rpc-address $POOL_ADDRESS --mining-threads $CPU_THREADS" >> start_miner.sh
    chmod +x start_miner.sh
    MINING_SCRIPT="$(pwd)/start_miner.sh"
    echo "tmux new-session \"bash $MINING_SCRIPT\"" >> $HOME/.bashrc
    tmux new-session "bash $MINING_SCRIPT"
fi
