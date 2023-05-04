pipeline{
    agent any
    stages{
    	stage("SCM"){
		sh "git clone https://github.com/Nishant5050/devops-candidate-exam.git"

	}
        stage("TF Init"){
            steps{
	    	  sh "cd devops-candidate-exam"
                  sh "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
	
		sh "cd devops-candidate-exam"
                sh "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
	        
		sh "cd devops-candidate-exam"
                sh "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
	    	
		sh "cd devops-candidate-exam"
                sh "terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{

		sh "cd devops-candidate-exam"
		sh "aws lambda invoke --function-name lambda-function --cli-binary-format raw-in-base64-out --payload '{"subnet_id": "","name":"Nishnat Fakkad Shete","email":"nishantshete9999@gmail.com"}' response.json"
		



            }
        }
    }
}
