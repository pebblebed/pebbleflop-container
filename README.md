Customized for a lambda host so far, assumes we're running a somewhat long-lived container
for program members to ssh into.

1. Run ./host-setup.sh to get the right docker stuff set up. On success you should
see output from `nvidia-smi` that reflects the machine's GPU

2. Create a Tailscale auth key for this machine, as described here:
https://tailscale.com/kb/1085/auth-keys/

3. Build this docker image with a hostname and the auth key:

`docker build . -t cuda-tailscale --build-arg TS_AUTHKEY=${TS_AUTHKEY} --build-arg TS_HOSTNAME=${TS_HOSTNAME}`

4. Fire it up:

`docker run \
	--d \
	--runtime=nvidia --gpus all \
	cuda-tailscale`
