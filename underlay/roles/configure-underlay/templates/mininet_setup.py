#!/usr/bin/python

from mininet.net import Mininet
from mininet.log import setLogLevel
from mininet.node import Controller, RemoteController, OVSSwitch, OVSBridge, Host
from mininet.link import Intf, OVSLink
from mininet.cli import CLI, quietRun
from flask import Flask, jsonify, abort, request, make_response, url_for
import json
from os import listdir,_exit
from os.path import isfile, join

app = Flask(__name__)
net = None

switches={}

def startLab():
  net = Mininet( topo=None, switch=OVSSwitch, build=False )
  net.addController('c1', controller=RemoteController, ip='127.0.0.1', port=6653)

  s1 = net.addSwitch('s1')
  switches['s1']=s1

  s2 = net.addSwitch('s2')
  switches['s2']=s2

  s3 = net.addSwitch('s3')
  switches['s3']=s3

  s4 = net.addSwitch('s4')
  switches['s4']=s4

  s5 = net.addSwitch('s5')
  switches['s5']=s5

  s6 = net.addSwitch('s6')
  switches['s6']=s6
  
  net.addLink( s5, s1 )
  net.addLink( s5, s2 )
  net.addLink( s5, s3 )
  net.addLink( s5, s4 )

  net.addLink( s6, s1 )
  net.addLink( s6, s2 )
  net.addLink( s6, s3 )
  net.addLink( s6, s4 )

  net.addLink( s5, s6 )

  net.start()

  return net

@app.errorhandler(400)
def not_found(error):
  return make_response(jsonify( { 'error': 'Bad request' } ), 400)
 
@app.errorhandler(404)
def not_found(error):
  return make_response(jsonify( { 'error': 'Not found' } ), 404)

@app.route('/exit', methods = ['GET'])
def exitNet():
  stop()
  _exit(0)

@app.route('/stop', methods = ['GET'])
def stopNet():
  stop()
  return make_response(jsonify( { 'message': 'stopped network' } ), 200)

@app.route('/start', methods = ['GET'])
def startNet():
  print ("start")
  if start():
    return make_response(jsonify( { 'message': 'started network' } ), 200)
  else:
    return make_response(jsonify( { 'error': 'could not start' } ), 404)

def start( ):
  print ("Start network.")
  global net
  if net is None:
    net = startLab()
  return True

def stop( ):
  global net
  if net is not None:
    net.stop()
    net = None

if __name__ == '__main__':
  app.run(host='0.0.0.0',debug = True)
