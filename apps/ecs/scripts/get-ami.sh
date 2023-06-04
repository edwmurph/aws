#!/bin/bash

aws ssm get-parameters \
  --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended
