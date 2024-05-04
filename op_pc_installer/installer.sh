#!/usr/bin/bash
cd ~/openpilot;
USE_WEBCAM=1 scons -j$(nproc);
