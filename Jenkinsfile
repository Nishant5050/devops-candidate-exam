pipeline{
    agent any
    stages{
    	stage("SCM"){
		sh "git clone https://github.com/Nishant5050/devops-candidate-exam.git"

	}
        stage("TF Init"){
            steps{
                  sh "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                sh "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
                sh "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
                sh "terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
               
		sh "aws lambda invoke --function-name lambda-function --cli-binary-format raw-in-base64-out --payload '{"subnet_id": "","name":"Nishnat Fakkad Shete","email":"nishantshete9999@gmail.com"}' response.json"
		



            }
        }
    }
}
