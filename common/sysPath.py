#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os

def root_path():
  current_path = os.getcwd();
  _path = os.path.dirname(current_path);
  return _path;