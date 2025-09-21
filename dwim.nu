#!/usr/bin/env nu

def main [] {
  use std/clip
  clip paste | dwim
}

def dwim [] {
  const yt_hosts = [
  youtube.com
  www.youtube.com
  youtu.be
  ]
  $in
  | url parse
  | if $in.host in $yt_hosts {
    mpv ($in | url join)
  }
}
