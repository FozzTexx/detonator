#!/usr/bin/env python
# Copyright 2006-2015 by Chris Osborn <fozztexx@fozztexx.com>
# http://insentricity.com/a.cl/243
#
# Very simple script to turn on relays passed on command line, wait 5
# seconds, and turn them off.
#
# This file is part of detonator.
#
# detonator is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2.1, or (at your option) any later
# version.
#
# detonator is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License
# along with detonator; see the file COPYING. If not see
# <http://www.gnu.org/licenses/>.

import sys
import RPi.GPIO as GPIO
import time
import random

CLOCK = 4
OE = 17
DATA = 21
LATCH = 22
NUM_RELAYS = 24

relay = [0] * NUM_RELAYS

for i in sys.argv[1:]:
  relay[int(i)] = 1

GPIO.setmode(GPIO.BCM)

GPIO.setup(CLOCK, GPIO.OUT)
GPIO.setup(DATA, GPIO.OUT)
GPIO.setup(LATCH, GPIO.OUT)
GPIO.setup(OE, GPIO.OUT)

for i in reversed(range(24)):
  GPIO.output(DATA, relay[i] == 0)
  GPIO.output(CLOCK, True)
  GPIO.output(CLOCK, False)
GPIO.output(LATCH, True)
GPIO.output(LATCH, False)

# Turn on shift registers
GPIO.output(OE, False)
time.sleep(3)

# Turn everything off
for i in reversed(range(24)):
  GPIO.output(DATA, 1)
  GPIO.output(CLOCK, True)
  GPIO.output(CLOCK, False)
GPIO.output(LATCH, True)
GPIO.output(LATCH, False)

GPIO.cleanup()
