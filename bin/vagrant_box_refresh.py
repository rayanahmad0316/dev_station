#!/usr/bin/env python

import argparse
import os
import subprocess

parser = argparse.ArgumentParser(description="Refresh Vagrant base box from Virtualbox VM.")
parser.add_argument("vm_name", help="Virtualbox VM name.")
parser.add_argument("--matchvm", dest="vm_name_match", action="store_true", help="Find matching VM name using `vm_name` as a prefix.")
parser.add_argument("box_name", help="Vagrant box name.")
parser.add_argument("--version", dest="box_version", help="Vagrant box version.")

args = parser.parse_args()

box_filename = "{}.box".format(args.box_name.replace("/","-"))

if os.path.exists(box_filename):
    os.unlink(box_filename)

if args.vm_name_match:
    vm_prefix = args.vm_name
    vm_names = []
    vm_text = subprocess.check_output(("VBoxManage", "list", "vms"),
        universal_newlines=True)
    for vm_line in vm_text.strip().split("\n"):
        vm_line_chunks = vm_line.split()
        entire_vm_name = vm_line_chunks[0].strip('"')
        if entire_vm_name.startswith(vm_prefix):
            vm_names.append(entire_vm_name)

    if len(vm_names) < 1:
        raise argparse.ArgumentError("VM matching '{}' not found.".format(
            vm_prefix))
    elif len(vm_names) > 1:
        raise argparse.ArgumentError("Multiple VMs matching '{} found.".format(
            vm_prefix))
    else:
        vm_name = vm_names[0]

else:
    vm_name = args.vm_name

subprocess.check_call(("vagrant", "package", "--base", vm_name, "--output", box_filename))

box_add_cmd = ["vagrant", "box", "add", box_filename, "--name", args.box_name, "--force"]
if args.box_version:
    box_add_cmd.extend(["--box-version", args.box_version])

subprocess.check_call(box_add_cmd)
