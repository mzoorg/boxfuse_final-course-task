resource "aws_instance" "aws-host1" {
    ami = var.ubuntu_image_id
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.allow_ssh.name}"]
    key_name = aws_key_pair.mykeypair22.key_name

    #If content files placed locally. If no, use git clone instead
        
    provisioner "remote-exec" {
        inline = [
            "until [ -f /var/lib/cloud/instance/boot-finished ]; do sleep 1; done",
            "sudo apt update", "sudo apt install -y software-properties-common python3-pip",
            "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py",
            "sudo python3 get-pip.py", "sudo python3 -m pip install ansible", "sudo pip install docker-py",
            "sudo ansible-galaxy collection install community.docker"            
        ]
    }
    
    connection {
            type     = "ssh"
            user     = var.username
            host     = self.public_ip
            private_key = var.my_private_key
        }
}

resource "aws_instance" "aws-host2" {
    ami = var.ubuntu_image_id
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.allow_ssh.name}","${aws_security_group.allow_http.name}"]
    key_name = aws_key_pair.mykeypair22.key_name
    
    provisioner "remote-exec" {
        inline = [
            "until [ -f /var/lib/cloud/instance/boot-finished ]; do sleep 1; done",
            "sudo apt update", "sudo apt install -y docker.io"
        ]
    }
    
    connection {
            type     = "ssh"
            user     = var.username
            host     = self.public_ip
            private_key = var.my_private_key
        }
}

resource "null_resource" "aws-host1_exec_ansible_buld" {
    depends_on = [ aws_instance.aws-host1 ]
    
    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "file" {
        source      = "content"
        destination = "/home/ubuntu/"
    }

    provisioner "remote-exec" {
        inline = ["sudo ansible-playbook /home/ubuntu/content/build.yml --extra-vars \"my_dockerhub_pass=${var.my_dockerhub_pass}\""]
    }
    
    connection {
            type     = "ssh"
            user     = var.username
            host     = "${aws_instance.aws-host1.public_ip}"
            private_key = var.my_private_key
        }
}

resource "null_resource" "aws-host2_exec_ansible_buld" {
    depends_on = [ "aws_instance.aws-host2", "null_resource.aws-host1_exec_ansible_buld" ]
    
    triggers = {
        always_run = "${timestamp()}"
    }

    provisioner "remote-exec" {
        inline = ["sudo docker run -d -p 80:8080 mzoorg/boxfuse-img"]
    }
    
    connection {
            type     = "ssh"
            user     = var.username
            host     = "${aws_instance.aws-host2.public_ip}"
            private_key = var.my_private_key
        }
}
