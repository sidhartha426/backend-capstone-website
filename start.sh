#!/bin/bash
# Check if the URL parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi


website_url="$1"
photo_url=$(echo "$website_url" | sed 's/8000/3000/')
songs_url=$(echo "$website_url" | sed 's/8000/8080/')



echo "MONGO_USER=root" > .env
echo "MONGO_PASS=olw92tWUWVCEqHVDUSy9hxoB" >> .env

echo "MONGODB_SERVICE=mongo_db" > ../backend-capstone-songs/backend/.env
echo "MONGODB_USERNAME=root" >> ../backend-capstone-songs/backend/.env
echo "MONGODB_PASSWORD=olw92tWUWVCEqHVDUSy9hxoB"  >> ../backend-capstone-songs/backend/.env

echo "SONGS_URL=$songs_url/song" > ./concert/.env
echo "PHOTO_URL=$photo_url/picture" >> ./concert/.env


cd ../backend-capstone-songs
docker build . -t flask_song
cd ..

cd backend-capstone-pictures
docker build . -t flask_picture
cd ..

cd backend-capstone-website
docker build . -t django_website
docker compose up -d