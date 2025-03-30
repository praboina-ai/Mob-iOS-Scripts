lane : deploy do 
    increment_build_number
    gym(scheme: "MyApp") #Build iOS App
    pilot   #Upload to TestFlight
    deliver #Deploy to App Store
end

lane : sign do
    sigh(force: true)
end

lane : appstore-sign do
    match(type: "appstore", force: true)
    git_url: "git@github.com:Mob-Scripts/certificates.git"
    git_branch: "master"
end

lane : test do
    scan(scheme: "MyApp")
end

lane : slack do |options|
    slack(
        message: options[:message],
        success: options[:success],
        webhook_url: options[:webhook_url]
    )
end

lane : beta do
    gym(scheme: "MyApp")

    firebase_app_distribution(
        app: "1:XXXXXXXXXXXX:ios:XXXXXXXXXXXXXXXX",
        groups: "internal-testers",
        ipa_path: "MyApp.ipa"
    )
end

slack(
    message: "Deployed successfully",
    success: true
    webhook_url: "https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXX
)