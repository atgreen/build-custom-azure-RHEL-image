all: rhel7.vhd

rhel7.qcow2: rhel-server-7.5-x86_64-kvm.qcow2
	cp $< $@ 
	virt-customize -a $@ \
		--root-password password:$(OSPASSWD) \
		--run-command 'subscription-manager register --force --username $(RHUSER) --password $(RHPASSWD) --auto-attach' \
		--run-command 'subscription-manager repos --disable=\*' \
		--run-command 'subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms' \
		--run-command 'yum -y remove cloud-init' \
		--run-command 'yum -y update' \
		--run-command 'yum -y install WALinuxAgent' \
		--run-command 'systemctl enable waagent.service' \
		--append-line '/etc/dracut.conf:add_drivers+="hv_vmbus hv_netvsc hv_storvsc"' \
		--run-command 'dracut -f -v --regenerate-all' \
		--run-command 'subscription-manager unregister'
	virt-sysprep --selinux-relabel -a $@

rhel7.raw: rhel7.qcow2
	qemu-img convert -f qcow2 -O raw $< $@

rhel7.vhd: rhel7.raw
	./convert-image.sh

clean:
	rm -f rhel7.* *~
