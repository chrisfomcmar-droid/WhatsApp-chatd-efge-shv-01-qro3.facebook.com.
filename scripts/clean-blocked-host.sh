#!/bin/bash

# Script to clean blocked hosts
# This script removes entries from the hosts file or firewall rules

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
HOSTS_FILE="/etc/hosts"
BACKUP_DIR="${HOME}/.backup/hosts"

# Functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root for system-wide changes
check_permissions() {
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root for system-wide changes"
        exit 1
    fi
}

# Create backup
backup_hosts() {
    mkdir -p "$BACKUP_DIR"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    cp "$HOSTS_FILE" "$BACKUP_DIR/hosts.backup.$timestamp"
    print_info "Backup created: $BACKUP_DIR/hosts.backup.$timestamp"
}

# Remove blocked host entry
remove_host_entry() {
    local host=$1
    if grep -q "$host" "$HOSTS_FILE"; then
        sed -i "/$host/d" "$HOSTS_FILE"
        print_info "Removed host entry: $host"
    else
        print_warning "Host entry not found: $host"
    fi
}

# Main execution
main() {
    print_info "Starting blocked host cleanup..."
    
    if [[ $# -eq 0 ]]; then
        print_error "No host specified. Usage: $0 <hostname> [hostname2] ..."
        exit 1
    fi
    
    check_permissions
    backup_hosts
    
    for host in "$@"; do
        remove_host_entry "$host"
    done
    
    print_info "Cleanup completed successfully"
}

main "$@"
