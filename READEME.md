#Deploy Terraform Infrastructure

terraform init
terraform apply -auto-approve

#Run Ansible Playbook
ansible-playbook -i inventory.ini setup-mac.yml

#Once Terraform provisions Infrastruture and Ansible Playbook is executed, you can connect to the MacOS machine using the following command:
cd ios
fastlane init

# Run Fastlane Build & Deployment
fastlane deploy


Terraform + remote-exec #Basic Configuration
Terraform + Ansible #Advanced Configuration
Terraform + USer Data #One-time setup via cloud-init [limited for macOS]

1) Terraform provisions AWS Mac EC2 Instance
2) Ansible installs Xcode, Fastlane, Xcodebuild, and other dependencies
3) Fastlane builds and deploys the iOS app
4) GitHub/Jenkins integrates with CI/cd

Firebase App Distribution for Testers
1) Get Firebase App Distribution App id

Install Firebase CLI
brew install firebase-cli
firebase login:ci


################################################################################################

A .p8 file is a private key file used in Apple's App Store Connect API for authentication, particularly when managing push notifications, App Store submissions, and signing with Apple's Developer Program.

Common Uses of a .p8 File:
Apple Push Notification Service (APNs) authentication.
App Store Connect API for automating TestFlight and App Store uploads.
JWT Authentication for Apple services.


Here are some important iOS Build & Automation interview questions categorized for different topics:

🔹 General iOS Build Process
What are the different types of iOS builds?

Debug: Used during development with debug symbols.
Release: Optimized for production, stripping debug symbols.
Ad-Hoc: For distribution to testers outside the App Store.
Enterprise: For in-house app distribution.
App Store: Signed for App Store submission.
What is Code Signing in iOS?

Code signing ensures the app is from a trusted developer.
Requires provisioning profiles & certificates.
What are Provisioning Profiles, and how are they different from Certificates?

Provisioning Profile: Defines which devices & developers can run the app.
Certificate: Used to sign apps and verify developer identity.
🔹 Fastlane & Automation
What is Fastlane, and why is it used?

Fastlane is an open-source tool that automates the iOS release process (build, test, deploy).
How do you define lanes in Fastlane?

Lanes are defined in the Fastfile. Example:
ruby
Copy
Edit
lane :beta do
  gym(scheme: "MyApp") # Builds the app
  upload_to_testflight  # Uploads to TestFlight
end
How to automate iOS builds using Fastlane?

Install Fastlane: gem install fastlane
Initialize: fastlane init
Define lanes in Fastfile
Run: fastlane beta (for TestFlight upload)
How do you handle signing in Fastlane?

Use match to manage certificates and profiles:
ruby
Copy
Edit
lane :signing do
  match(type: "appstore", readonly: true)
end
How do you manage environment variables in Fastlane?

Use .env files or pass them via CLI:
sh
Copy
Edit
FASTLANE_USER=email@example.com fastlane beta
🔹 iOS CI/CD & Deployment
How do you set up CI/CD for an iOS app?

Use GitHub Actions, Bitrise, Jenkins, or GitLab CI with Fastlane.
How do you deploy an iOS app to TestFlight or the App Store?

Use Fastlane:
ruby
Copy
Edit
upload_to_testflight
upload_to_app_store
How do you integrate iOS CI/CD with GitHub Actions?

Example ios-ci.yml:
yaml
Copy
Edit
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: bundle install
      - name: Build and Test
        run: fastlane test
      - name: Deploy to TestFlight
        run: fastlane beta
How do you distribute an iOS app to a specific group of testers?

Use TestFlight with groups (upload_to_testflight with groups: "QA").
🔹 iOS Dependency Management
What are the different dependency managers in iOS?

CocoaPods: pod install
Carthage: carthage update --platform iOS
Swift Package Manager (SPM): Integrated in Xcode.
How to handle dependency caching in CI/CD?

Cache dependencies in CI (e.g., GitHub Actions):
yaml
Copy
Edit
- uses: actions/cache@v2
  with:
    path: Pods
    key: ${{ runner.os }}-pods-${{ hashFiles('Podfile.lock') }}
🔹 iOS Testing Automation
How do you automate iOS UI testing?

Use XCTest & XCUITest:
swift
Copy
Edit
func testLogin() {
    let app = XCUIApplication()
    app.launch()
    app.textFields["username"].tap()
    app.textFields["username"].typeText("testuser")
    app.buttons["Login"].tap()
    XCTAssertTrue(app.staticTexts["Welcome"].exists)
}
How to integrate iOS unit tests in CI?

Run tests in GitHub Actions:
yaml
Copy
Edit
- name: Run Tests
  run: fastlane scan
How do you capture crash logs for an iOS app?

Use Xcode Organizer or tools like New Relic, Firebase Crashlytics.
🔹 Security & App Store Guidelines
How do you ensure an iOS app is secure?

Enable App Transport Security (ATS)
Store sensitive data in Keychain
Use Bitcode & Hardened Runtime
What is App Transport Security (ATS)?

Enforces HTTPS connections to prevent data leaks.
How do you detect and fix App Store rejections?

Check App Store Connect rejection reason
Use TestFlight for pre-validation
Review App Store Guidelines before submission.
