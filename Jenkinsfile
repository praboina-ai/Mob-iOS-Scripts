pipeline {
    agent { label 'macos' }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: '
                git 'https:github.com/username/Mob-Scripts.git'
            }
        }
        stage('Install dependencies') {
            steps {
               sh 'gem install bundler'
               sh 'bundle install'
               sh 'gem install cocoapods'
               sh 'pod install'
            }
        }
        stage('Build') {
            steps {
                sh 'xcodebuild -project Mob.xcodeproj -scheme Mob -destination "platform=iOS Simulator,name=iPhone 11" build test'
            }
        }
        stage('Build & Deploy') {
            steps {
                sh 'fastlane deploy'
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'build/Release-iphoneos/*.ipa', fingerprint: true
            }
        }

    }
}