ssh:
  pkg.installed

openssh:
  service.running:
    - name: ssh
