pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-user/your-repo.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Inject .env File') {
            steps {
                withCredentials([file(credentialsId: 'my-env-file', variable: 'ENV_FILE')]) {
                    sh '''
                    cp $ENV_FILE .env
                    export $(cat .env | xargs)
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                sh '''
                export $(cat .env | xargs)
                npm test
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                export $(cat .env | xargs)
                npm run build
                '''
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'my-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                    sh '''
                    chmod 600 $SSH_KEY

                    # Define variables
                    REMOTE_USER=user
                    REMOTE_HOST=remote.server.com
                    REMOTE_DIR=/var/www/my-app

                    # Rsync the built folder to remote server (adjust folder if needed)
                    rsync -avz -e "ssh -i $SSH_KEY" --delete ./dist/ $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/dist/

                    # SSH into the remote server and restart app using PM2
                    ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST '
                        cd /var/www/my-app &&
                        pm2 restart all || pm2 start server.js --name my-express-app
                    '
                    '''
                }
            }
        }
    }
}

