from typing import List, Tuple
from rlbench.backend.task import Task
from pyrep.objects import ProximitySensor, Shape

from rlbench.backend.task import Task
from pyrep.objects.dummy import Dummy

from rlbench.backend.conditions import DetectedCondition, GraspedCondition

from rlbench.backend.spawn_boundary import SpawnBoundary
from rlbench.const import colors
import numpy as np

class SortingProgram5(Task):

    def init_task(self) -> None:
        self.target_block = Shape('target_block')
        
        self.target_container0 = Shape('small_container0')
        self.target_container1 = Shape('small_container1')
        self.boundary = Shape('boundary')
        self.distractor_block0 = Shape('distractor_block0')
        self.distractor_block1 = Shape('distractor_block1')
        self.box_boundary = Shape('box_boundary')

        self.register_graspable_objects([self.target_block])
        success_sensor = ProximitySensor('success')
        self.success_detector0 = ProximitySensor('success0')
        self.success_detector1 = ProximitySensor('success1')
        self.register_success_conditions([
            # DetectedCondition(self.robot.arm.get_tip(), success_sensor),
            # GraspedCondition(self.robot.gripper, self.target_block),
            DetectedCondition(self.target_block, self.success_detector0)
        ])
        

    def init_episode(self, index: int) -> List[str]: 
        # index come from variation
        color_name, color_rgb = colors[index] 
        # color_choices = np.random.choice(list(range(index)) 
        # + list(range(index +1, len(colors))),size=2,replace=False)
        
        # for ob, i in zip([self.distractor_block0, self.distractor_block1],
        #                  color_choices):
        #     ob.set_color(colors[i][1])
        # self.target_container1.set_color(colors[i][1])
            
        # self.target_block.set_color(color_rgb)
        # self.target_container0.set_color(color_rgb)
        
        boundary_spawn = SpawnBoundary([self.boundary])
        try:
            for ob in [self.target_block, self.distractor_block0, self.distractor_block1]:
                boundary_spawn.sample(ob, min_distance=0.09, min_rotation=(0, 0, 0), max_rotation=(0, 0, 0.785)) # 0.395
        except:
            for ob in [self.target_block, self.distractor_block0, self.distractor_block1]:
                boundary_spawn.sample(ob, min_distance=0.09, min_rotation=(0, 0, 0), max_rotation=(0, 0, 0.785)) # 0.395
        
        box_boundary_spawn = SpawnBoundary([self.box_boundary])
        
        try:
            for ob in [self.target_container0, self.target_container1]:
                box_boundary_spawn.sample(ob, min_distance=0, min_rotation=(0, 0, 0), max_rotation=(0.785, 0, 0)) # 0.395
        except:
            for ob in [self.target_container0, self.target_container1]:
                box_boundary_spawn.sample(ob, min_distance=0, min_rotation=(0, 0, 0), max_rotation=(0.785, 0, 0)) # 0.395
            
        return ['grasp the %s target' % color_name,
                'put the %s target to the %s box' % (color_name, color_name)]  
    

    def variation_count(self) -> int:
        return len(colors)
    
    def base_rotation_bounds(self) -> Tuple[Tuple[float, float, float], Tuple[float, float, float]]:
        return [0.0, 0.0, 0.0],[0.0, 0.0, 0.0]
    
    def is_static_workspace(self) -> bool:
        return True