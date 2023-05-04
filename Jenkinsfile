pipeline{
    agent any
    stages{
    	stage("SCM"){
		steps{
		sh "git clone https://github.com/Nishant5050/devops-candidate-exam.git"
	   }
	}
        stage("TF Init"){
            steps{
	    	  sh "cd devops-candidate-exam && terraform init"
            }
        }
        stage("TF Validate"){
            steps{
	
		sh "cd devops-candidate-exam && terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
	        
		sh "cd devops-candidate-exam && terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
	    	
		sh "cd devops-candidate-exam && terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{

		sh "cd devops-candidate-exam && aws lambda invoke --function-name lambda-function --cli-binary-format raw-in-base64-out --payload '{"subnet_id": "vpc-00bf0d10a6a41600c","name":"Nishnat Fakkad Shete","email":"nishantshete9999" }' response.json"

            }
        }
    }
}
