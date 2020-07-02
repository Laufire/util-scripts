#!/usr/bin/env python
r'''
A simple HTTP server implementation with CORS enabled.
'''
from sys import argv
import os
from os.path import abspath
from SimpleHTTPServer import SimpleHTTPRequestHandler
import BaseHTTPServer

class CORSRequestHandler (SimpleHTTPRequestHandler):
    def end_headers (self):
        self.send_header('Access-Control-Allow-Origin', '*')
        SimpleHTTPRequestHandler.end_headers(self)

def main():
    baseDir = abspath(argv[2] if len(argv) > 2 else '.')
    os.chdir(baseDir)
    BaseHTTPServer.test(CORSRequestHandler, BaseHTTPServer.HTTPServer)

if __name__ == '__main__':
    main()
