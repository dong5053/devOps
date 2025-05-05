#!/bin/bash

set -e

echo "[STEP 1] Parallels .hdd 디스크 파일 생성..."
./create_disks.sh

echo "[STEP 2] Vagrant 클러스터 시작 중..."
vagrant up --provider=parallels

echo "[STEP 3] Ansible 설치 확인 및 설치..."
if ! command -v ansible >/dev/null 2>&1; then
  echo "  [INFO] Ansible이 설치되어 있지 않아 설치합니다 (Homebrew 사용)."
  if ! command -v brew >/dev/null 2>&1; then
    echo "  [ERROR] Homebrew가 설치되어 있지 않습니다. 먼저 brew를 설치해주세요."
    exit 1
  fi
  brew install ansible
else
  echo "  [INFO] Ansible이 이미 설치되어 있습니다."
fi

echo "[STEP 4] Ansible Playbook 실행..."
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml

echo "[DONE] 모든 작업이 완료되었습니다."
