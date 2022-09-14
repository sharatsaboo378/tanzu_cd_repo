terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.1.0"
    }
   

    #azurerm = {
     # source = "hashicorp/azurerm"
      #version = "~>2.0"
    #}
  }
}

#provider "azurerm" {
#  features {}
#}

provider "null" {
}


resource "null_resource" "creating_local_repo" {
  provisioner "local-exec" {
	command = "git init"
  }
}

resource "null_resource" "adding_files_to_local_repo" {
  provisioner "local-exec" {
	command = "git add ."
  }
  depends_on = [null_resource.creating_local_repo]
}

resource "null_resource" "adding_user_email" {
  provisioner "local-exec" {
	command = "git config --global user.email \"${var.dockerhub_registry_email}\""
  }
  depends_on = [null_resource.adding_files_to_local_repo]
}

resource "null_resource" "adding_user_name" {
  provisioner "local-exec" {
	command = "git config --global user.name \"${var.your_name}\""
  }
  depends_on = [null_resource.adding_user_email]
}

resource "null_resource" "commit" {
  provisioner "local-exec" {
	command = "git commit -m \"InitialCommit\" "
  }
  depends_on = [null_resource.adding_user_name]
}

resource "null_resource" "creating_main_branch" {
  provisioner "local-exec" {
	command = "git branch -M main"
  }
  depends_on = [null_resource.commit]
}

resource "null_resource" "adding_remote_repo" {
  provisioner "local-exec" {
	command = "git remote add origin ${var.github_cd_repo_url}"
  }
  depends_on = [null_resource.creating_main_branch]
}

#resource "null_resource" "pushing_to_remote_repo" {
 # provisioner "local-exec" {
#	command = "git push -u origin main"
 # }
  #depends_on = [null_resource.adding_remote_repo]
#}




