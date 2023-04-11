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
		
		stage ('Check-Git-Secrets'){
			steps{
				sh 'rm output || true'
				sh 'docker run gesellix/trufflehog --json https://github.com/nikhhilanand/DevSecOpsLabs.git > output'
				sh 'cat output'
			}	
		}
		
		stage ('Source Composition Analysis') {
		      steps {
				 sh 'rm web* || true'
				 sh 'wget "https://raw.githubusercontent.com/nikhhilanand/DevSecOpsLabs/master/owasp-dependency-check.sh" '
				 sh 'chmod +x owasp-dependency-check.sh'
				 sh 'bash owasp-dependency-check.sh'
				 //sh 'cat /var/lib/jenkins/OWASP-Dependency-Check/reports/dependency-check-report.xml'
		      }
		 }
		
		stage ('Build'){
			steps{
				sh 'mvn clean package'
			}	
		}
		
		stage ('Deploy-To-Tomcat') {
		    	steps {
		   		sshagent(['de46408b-0391-4f62-85f4-240594db4874']) {
					sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@15.206.178.125:/home/ubuntu/prod/apache-tomcat-10.1.7/webapps/webapp.war'
              			}
			}	
           	}       
	}
}
