pipeline{
	agent any
	
	tools{
	maven 'Maven'
	}
	
	stages{
		stage ('Initialize'){
			steps{
				sh '''
					echo "PATH = ${PATH}"
					echo "M2_HOME = ${M2_HOME}"
				'''	
			}
		}
		
		stage ('Build'){
			steps{
				sh 'mvn clean package'
			}	
		}
		
		stage ('Deploy-To-Tomcat') {
		    	steps {
		   		sshagent(['tomcat']) {
					sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@15.206.178.125:/home/ubuntu/prod/apache-tomcat-10.1.7/webapps/webapp.war'
              			}
			}	
           	}       
	}
}
