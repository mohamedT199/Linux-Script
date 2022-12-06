#!/bin/bash 

#for manage permission to be excuted on nay system 
setPermissionForScripts=$1
user=$(whoami)

chmod -R $setPermissionForScripts ./*
