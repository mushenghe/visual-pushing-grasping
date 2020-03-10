# Visual Pushing and Grasping 
## Problem Statement
Most grasping algorithms today often fail to handle scenarios where objects are tightly packed together. They can attempt bad grasps repeatedly to no avail since they can only find accessible grasps. This project proposed to discover and learn synergies between pushing and grasping from experience through model-free deep reinforcement learning.

<img src="images/method.jpg" width=100%/>

## Model Input & Output
The Q-function is modeled as two feed-forward fully convolutional networks(FCNs) Φ<sub>p</sub> and Φ<sub>g</sub>. FCN Φ<sub>p</sub> is for pushing motion primitive behavior and FCN Φ<sub>g</sub> is for grasping. 

For each individual FCN Φ<sub>ψ</sub>:
* Input:  the  heightmap  image representation of the current state 
* Output: a dense pixel-wisemap  of  Q  values  with  the  same  image  size  and  resolution as that of the state

Note: each individual Q value prediction at a pixel p represents the future  expected  reward  of  executing primitive ψ at  3D  location q where q→p ∈s<sub>t</sub>. 
## Pretrained Model
* [VPG model used in simulation environment](http://vision.princeton.edu/projects/2018/vpg/downloads/vpg-original-sim-pretrained-10-obj.pth)
* [VPG model used in real world](http://vision.princeton.edu/projects/2018/vpg/downloads/vpg-original-real-pretrained-30-obj.pth)
## Installation(2 Options)
Note: Both options 1 and 2 can be executed from a cloud service provider or from your local machine.
#### Option1 - With Docker:
* Use Docker to pull down the docker image
  ```shell
  sudo docker pull mushenghe/adl_pushing_grasping:firsttry
  ```

#### Option2 - Run from code:
This implementation requires the following dependencies (tested on Ubuntu 16.04.4 LTS and above): 

* Python 2.7 or Python 3 
  ```
  sudo apt install python2.7
  ```
* [NumPy](http://www.numpy.org/), [SciPy](https://www.scipy.org/scipylib/index.html), [OpenCV-Python](https://docs.opencv.org/3.0-beta/doc/py_tutorials/py_tutorials.html), [Matplotlib](https://matplotlib.org/)
  ```shell
  pip install numpy scipy opencv-python matplotlib
  ```
* [PyTorch](http://pytorch.org/) version 0.3.1 
  ```shell
  pip install torch==0.3.1 torchvision==0.2.0
  ```
* [V-REP](http://www.coppeliarobotics.com/) (simulation environment)

## Train the model

To train a regular VPG policy from scratch in simulation
* Start the simulation environment by running V-REP 
```
  cd vrep_ws/V-REP_PRO_EDU_V3_5_0_Linux
  ./vrep.sh
```
From the main menu, select File > Open scene..., and open the file grasp_ws/visual-pushing-grasping/simulation/simulation.ttt `
* Navigate to ```grasp_ws``` in another terminal window and run the following:

```shell
python main.py --is_sim --push_rewards --experience_replay --explore_rate_decay --save_visualizations
```

* Data (including RGB-D images, camera parameters, heightmaps, actions, rewards, model snapshots, visualizations, etc.) collected from each training session is saved into a directory in the `logs` folder. A training session can be resumed by adding the flags `--load_snapshot` and `--continue_logging`, which then loads the latest model snapshot specified by `--snapshot_file` and transition history from the session directory specified by `--logging_directory`:

```shell
python main.py --is_sim --push_rewards --experience_replay --explore_rate_decay --save_visualizations \
    --load_snapshot --snapshot_file 'logs/YOUR-SESSION-DIRECTORY-NAME-HERE/models/snapshot-backup.reinforcement.pth' \
    --continue_logging --logging_directory 'logs/YOUR-SESSION-DIRECTORY-NAME-HERE' \
```

* Various training options can be modified or toggled on/off with different flags (run `python main.py -h` to see all options):

```shell
usage: main.py [-h] [--is_sim] [--obj_mesh_dir OBJ_MESH_DIR]
               [--num_obj NUM_OBJ] [--tcp_host_ip TCP_HOST_IP]
               [--tcp_port TCP_PORT] [--rtc_host_ip RTC_HOST_IP]
               [--rtc_port RTC_PORT]
               [--heightmap_resolution HEIGHTMAP_RESOLUTION]
               [--random_seed RANDOM_SEED] [--method METHOD] [--push_rewards]
               [--future_reward_discount FUTURE_REWARD_DISCOUNT]
               [--experience_replay] [--heuristic_bootstrap]
               [--explore_rate_decay] [--grasp_only] [--is_testing]
               [--max_test_trials MAX_TEST_TRIALS] [--test_preset_cases]
               [--test_preset_file TEST_PRESET_FILE] [--load_snapshot]
               [--snapshot_file SNAPSHOT_FILE] [--continue_logging]
               [--logging_directory LOGGING_DIRECTORY] [--save_visualizations]
```

* Results from the baseline comparisons and ablation studies in the [paper](https://arxiv.org/pdf/1803.09956.pdf) can be reproduced using these flags. For example:

+ Train reactive policies with pushing and grasping (P+G Reactive); specify `--method` to be `'reactive'`, remove `--push_rewards`, remove `--explore_rate_decay`:

    ```shell
    python main.py --is_sim --method 'reactive' --experience_replay --save_visualizations
    ```

+ Train reactive policies with grasping-only (Grasping-only); similar arguments as P+G Reactive above, but add `--grasp_only`:

    ```shell
    python main.py --is_sim --method 'reactive' --experience_replay --grasp_only --save_visualizations
    ```

+ Train VPG policies without any rewards for pushing (VPG-noreward); similar arguments as regular VPG, but remove `--push_rewards`:

    ```shell
    python main.py --is_sim --experience_replay --explore_rate_decay --save_visualizations
    ```

+ Train shortsighted VPG policies with lower discount factors on future rewards (VPG-myopic); similar arguments as regular VPG, but set `--future_reward_discount` to `0.2`:

    ```shell
    python main.py --is_sim --push_rewards --future_reward_discount 0.2 --experience_replay --explore_rate_decay --save_visualizations
    ```

* To plot the performance of a session over training time, run 

```shell
python plot.py 'logs/YOUR-SESSION-DIRECTORY-NAME-HERE'
```
## Use the pretrained model
* Checkout this repository and download our pre-trained models
  ```
  cd grasp_ws/downloads
  ./download-weights.sh
  cd ..
  ```
* Run V-REP 
  ```
  cd vrep_ws/V-REP_PRO_EDU_V3_5_0_Linux
  ./vrep.sh
  ```
From the main menu, select File > Open scene..., and open the file grasp_ws/visual-pushing-grasping/simulation/simulation.ttt 
* In another terminal window, run 
  ```
python main.py --is_sim --obj_mesh_dir 'objects/blocks' --num_obj 10 \
    --push_rewards --experience_replay --explore_rate_decay \
    --is_testing --test_preset_cases --test_preset_file 'simulation/test-cases/test-10-obj-07.txt' \
    --load_snapshot --snapshot_file 'downloads/vpg-original-sim-pretrained-10-obj.pth' \
    --save_visualizations
  ```

If you run this code by ssh into GPU, remember to disable the visuliazation option or you would get error.

<img src="images/vrep.gif" width=100%/>
## Reference

```
@inproceedings{zeng2018learning,
  title={Learning Synergies between Pushing and Grasping with Self-supervised Deep Reinforcement Learning},
  author={Zeng, Andy and Song, Shuran and Welker, Stefan and Lee, Johnny and Rodriguez, Alberto and Funkhouser, Thomas},
  booktitle={IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)},
  year={2018}
}
```

