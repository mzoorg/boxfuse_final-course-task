# final_task_devops-school
1 Start from jenkins pipeline  
2 Run terraform code in jenkins-host  
3 Create aws-host1 and run ansible play-book to create a docker-image for build app  
4 build app in docker container  
5 deploy docker image with app and copy artifact there  

-----For local terraform -----  
1  change sshkey value in main.tf for: private_key = "${file("${var.path_to_key}")}"  
2 create localvars.tfvars and set vars: my_public_key, my_dockerhub_pass, path_to_key, username, ubuntu_image_id  
3 run terraform apply -auto-approve -var-file="localvars.tfvars"  
