#!/bin/bash

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP="ubuntu:GNOME"
export GNOME_SHELL_SESSION_MODE=ubuntu

exec gnome-session --session=ubuntu
