#!/bin/bash

############################### RPT ###############################
python3 RLBench/tools/dataset_generator_hdf5.py \
    --save_path Datasets \
    --tasks sorting_program5 \
    --variations 1 \
    --episodes_per_task 50

task_name=("sorting_program5")
model_type=(ACT0E0 ACT3E0 ACT3E2 ACT3E0)
epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
backbone_list=("efficientnet_b0")
chunk_size=(20)
for task in ${task_name[@]}
  do
  for model in ${model_type[@]}
    do
    for epoch in ${epoch_list[@]}
      do
      for backbone in ${backbone_list[@]}
        do
        for chunk in ${chunk_size[@]}
          do
          echo '##################################################################'
          echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
          echo '##################################################################'
          CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
          --task_name $task \
          --ckpt_dir Trainings \
          --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
          --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
          ; \
          CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
          --task_name $task \
          --ckpt_dir Trainings \
          --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
          --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
          --eval --temporal_agg 
          done
        done
      done
    done
  done

################################ RPT #################################################   
# task_name=("sorting_program5" )
# model_type=(ACT0E0 ACT3E0)
# epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
          
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
#           --eval --temporal_agg 
#           done
#         done
#       done
#     done
#   done
  
######################################## RPT2 
# task_name=("sorting_program5" )
# model_type=(ACT3E2 ACT3E3)
# epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
          
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
#           --eval --temporal_agg 
#           done
#         done
#       done
#     done
#   done

############################################## rpt3 ##############################################
# task_name=("meat_on_grill" )
# model_type=(ACT3E0)
# epoch_list=(13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
          
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone 
#           done
#         done
#       done
#     done
#   done

# task_name=("meat_on_grill")
# model_type=(ACT3E2 ACT3E0)
# epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone 
#           done
#         done
#       done
#     done
#   done

# # # python3 RLBench/tools/dataset_generator_hdf5.py \
# # #     --save_path Datasets \
# # #     --tasks meat_on_grill \
# # #     --variations 1 \
# # #     --episodes_per_task 50

# task_name=("meat_on_grill")
# model_type=(ACT0E0 ACT3E0 ACT3E2 ACT3E0)
# epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
#           --eval --temporal_agg 
#           done
#         done
#       done
#     done
#   done


# task_name=("meat_on_grill")
# model_type=(ACT3E2 ACT3E0)
# epoch_list=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000)
# backbone_list=("efficientnet_b0")
# chunk_size=(20)
# for task in ${task_name[@]}
#   do
#   for model in ${model_type[@]}
#     do
#     for epoch in ${epoch_list[@]}
#       do
#       for backbone in ${backbone_list[@]}
#         do
#         for chunk in ${chunk_size[@]}
#           do
#           echo '##################################################################'
#           echo 'train on model=' $model ', task=' $task ', epoch=' $epoch ',  chunk_size='$chunk 
#           echo '##################################################################'
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
#           ; \
#           CUDA_VISIBLE_DEVICES=0 python3 RPT_model/imitate_inference.py \
#           --task_name $task \
#           --ckpt_dir Trainings \
#           --policy_class $model --kl_weight 10 --chunk_size $chunk --hidden_dim 512 --batch_size 8 --dim_feedforward 3200 \
#           --num_epochs $epoch  --lr 1e-5 --seed 0 --backbone $backbone \
#           --eval --temporal_agg 
#           done
#         done
#       done
#     done
#   done


