//Author : nikhhilanand
/** Sample Jenkinsfile **/
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
		/**
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
			      	 sh 'cat /var/lib/jenkins/workspace/webapp-cicd-pipeline/odc-reports/dependency-check-report.xml'
				 //sh 'cat /var/lib/jenkins/OWASP-Dependency-Check/reports/dependency-check-report.xml'
		      }
		 }
		**/
		
		stage ('Build'){
			steps{
				sh 'mvn clean package'
			}	
		}
		/**
		stage ('SAST') {
			steps {
				withSonarQubeEnv('SonarQube') {
					sh 'mvn sonar:sonar'
					//sh 'cat target/sonar/report-task.txt'
				       }
			}
		}
		**/
		stage ('Deploy-To-Tomcat') {
		    	steps {
		   		sshagent(['de46408b-0391-4f62-85f4-240594db4874']) {
					sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@13.126.84.97:/home/ubuntu/prod/apache-tomcat-10.1.7/webapps/webapp.war'
				sh 'echo Deploy To Tomcat Executed'
              			}
			}	
           	}
		
		stage ('DAST') {
		    	steps {
			    sshagent(['zap']) {
				    sh 'ssh -o StrictHostKeyChecking=no ubuntu@65.2.187.237 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://13.126.84.97:8080/webapp/" || true'
			    }
			}
		}
		
	}
}
