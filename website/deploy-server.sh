# Setup
export ENV=production
export PROJECT_PATH=/var/www/geokaliz
export PORT=80
export ROOT_URL=http://laurent.tech
export MONGO_URL=mongodb://localhost:27017/geokaliz

# Dynamic (no need to touch)
export METEOR_SETTINGS=$(cat $PROJECT_PATH/website/config/$ENV/settings.json)

# Pull / Build
cd $PROJECT_PATH/website
git pull
sudo iron build
cd $PROJECT_PATH/website/build/bundle/programs/server
npm install
cd $PROJECT_PATH/website

# Launch
node $PROJECT_PATH/website/build/bundle/main.js
