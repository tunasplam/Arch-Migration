#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from time import sleep

tape = ["Hello World",
	"There", "test"]

for item in tape:
	print('\r', end='')
	print(item, end='')
	sleep(2)

