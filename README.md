On a Lambda host:

1. Add the ubuntu user to the docker group.

$  sudo usermod -aG docker $USER
$  newgrp docker  

2. Or pull this dockerfile
