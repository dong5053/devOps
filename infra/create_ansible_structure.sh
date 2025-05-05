#!/bin/bash

# 현재 스크립트가 위치한 디렉터리 기준
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/ansible"

echo "[+] Target base directory: $BASE_DIR"

# 기본 디렉터리 및 파일 생성
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit

echo "[+] inventory, playbook 파일 생성..."
touch inventory.ini playbook.yml

# Role 리스트
ROLES=(
  cni_install
  containerd_setup
  disk_setup
  docker_setup
  k8s_init
  k8s_install
  k8s_join
)

echo "[+] Ansible roles 구조 생성..."
for ROLE in "${ROLES[@]}"; do
  mkdir -p "roles/$ROLE/tasks"
  touch "roles/$ROLE/tasks/main.yml"

  # 특정 역할에만 handlers 생성
  if [[ "$ROLE" == "containerd_setup" || "$ROLE" == "docker_setup" ]]; then
    mkdir -p "roles/$ROLE/handlers"
    touch "roles/$ROLE/handlers/main.yml"
  fi
done

echo "[✓] Ansible role structure created under: $BASE_DIR"
