build-2023:
	docker build --pull -t personalroboticsimperial/prl:ub2004-cu113-isaacsim2023 --build-arg ISAACSIM_VERSION=2023.1.0 --file Dockerfile.2023.1.0-ubuntu20.04 .

build-2022:
	docker build --pull -t personalroboticsimperial/prl:ub2004-cu113-isaacsim2022 --build-arg ISAACSIM_VERSION=2022.2.1 --file Dockerfile.2022.2.1-ubuntu20.04 .


run-2022: ISAAC_YEAR=2022
run-2022: _run

run-2023: ISAAC_YEAR=2023
run-2023: _run

_run:
	xhost +
	docker run --name isaac-sim --entrypoint bash -it --gpus all -e "ACCEPT_EULA=Y" --rm --network=host \
  		-e "PRIVACY_CONSENT=Y" \
  		-v $$HOME/.Xauthority:/root/.Xauthority \
  		-e DISPLAY \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/cache/kit:/isaac-sim/kit/cache:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/cache/ov:/root/.cache/ov:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/cache/pip:/root/.cache/pip:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/cache/glcache:/root/.cache/nvidia/GLCache:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/cache/computecache:/root/.nv/ComputeCache:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/logs:/root/.nvidia-omniverse/logs:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/data:/root/.local/share/ov/data:rw \
  		-v ~/docker/isaac-sim/${ISAAC_YEAR}/documents:/root/Documents:rw \
  		personalroboticsimperial/prl:ub2004-cu113-isaacsim${ISAAC_YEAR} \
  		./runapp.sh

_push:
	docker push ${ISAAC_YEAR}


push-2022: ISAAC_YEAR=2022
push-2022: _push

push-2023: ISAAC_YEAR=2023
push-2023: _push