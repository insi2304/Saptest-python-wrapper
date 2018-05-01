#!/bin/bash

#Web server starting
python -m SimpleHTTPServer

./mclient &
./msrv.py