# baddies

A new Flutter project.

## Installing & Configuring Firebase
# flutterfire configure
# flutter pub add firebase_core

BUILD_VERSION := $(powershell if ((Get-Content pubspec.yaml) -match 'version: (.+)') { $matches[1] })



flutter clean
flutter pub get
flutter build web --base-href /featheries_web/ --release  

cd build\web
git init    
git add .   
git commit -m "Deploy 2"
git remote add origin https://github.com/chankwokweng/featheries_web.git
git branch -M main
git push -u origin main
make deploy-web        

