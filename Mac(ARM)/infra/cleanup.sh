#!/bin/bash

set -e

echo "[CLEANUP] 클러스터 정리 시작..."

echo "1. Vagrant VM 중지 및 제거"
vagrant destroy -f

echo "2. Parallels .hdd 디스크 파일 삭제"
DISK_PATHS=(
  "h-flow-master_extra_disk.hdd"
  "h-flow-worker1_extra_disk.hdd"
  "h-flow-worker2_extra_disk.hdd"
)

for disk in "${DISK_PATHS[@]}"; do
  if [ -e "$disk" ]; then
    echo "  [DELETE] $disk"
    rm -rf "$disk"
  else
    echo "  [SKIP] $disk (존재하지 않음)"
  fi
done

echo "[DONE] 클러스터 관련 리소스 정리 완료"
