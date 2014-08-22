#!/bin/bash

TARGET_IP=$2
LATENCY=$3
PACKET_LOSS=$4


case "$1" in
    install)
      ipfw add pipe 1 ip from any to $TARGET_IP;
      ipfw add pipe 2 ip from $TARGET_IP to any;
      ipfw pipe 1 config delay $LATENCY bw 1Mbit/s plr $PACKET_LOSS;
      ipfw pipe 2 config delay $LATENCY bw 1Mbit/s plr $PACKET_LOSS;
      ;;

    remove)
      ipfw -q flush
      ;;
    *)
      echo $"Usage: $0 {install|remove} TARGET_IP LATENCY PACKET_LOSS"
      exit 1
  esac

