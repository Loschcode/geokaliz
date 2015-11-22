# Setup
export ENV=development
export PROJECT_PATH=/Users/Loschcode/Google[[:space:]]Drive/projects/geokaliz_lo
export PORT=3000
export ROOT_URL=http://localhost:3000
export MONGO_URL=mongodb://root:root@localhost:27017/geokaliz

# Dynamic (no need to touch)
export METEOR_SETTINGS=$(cat $PROJECT_PATH/config/$ENV/settings.json)

# Build
cd $PROJECT_PATH/website
iron build
cd $PROJECT_PATH/build/bundle/programs/server
npm install
cd $PROJECT_PATH/website

# Launch
node $PROJECT_PATH/website/build/bundle/main.js