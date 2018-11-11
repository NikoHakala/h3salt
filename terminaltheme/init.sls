/home/xubuntu/.config/xfce4/terminal/terminalrc:
  file.managed:
    - source: salt://terminaltheme/terminalrc
    - user: xubuntu
    - group: xubuntu
    - makedirs: True
