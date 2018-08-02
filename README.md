Sample process for creating custom RHEL images for Azure
=======================================================

This is just a basic example process, not intended to be hardened in
any way.  We use virt-customize on a RHEL qcow2 image from Red Hat,
but you could just as easily use virt-install with ISO and kickstart
files.  In a Satellite managed infrastructure, use Activation Keys to
register to your Satellite.

For this example, set the following environment variables, and run
`make`.

* `ROOTPASSWD` : the root pw for the target image
* `RHUSER`     : the Red Hat portal user ID
* `RHPASSWD`   : the Red Hat portal password

Feel free to submit PRs or Issues.

AG
