#!/bin/bash

set -e

echo "[INFO] Parallels .hdd 디스크 파일 생성..."

DISK_PATHS=(
  "h-flow-master_extra_disk.hdd"
  "h-flow-worker1_extra_disk.hdd"
  "h-flow-worker2_extra_disk.hdd"
)

for disk in "${DISK_PATHS[@]}"; do
  if [ -e "$disk" ]; then
    echo "  [SKIP] $disk already exists"
  else
    echo "  [CREATE] $disk (50GB)"
    prl_disk_tool create --hdd "$disk" --size 51200
  fi
done

echo "[DONE] 모든 디스크 생성 완료"
