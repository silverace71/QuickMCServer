
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
    sudo apt install jq -y
    echo "${RED} !!!WARNING!!! ${YELLOW} YOU MIGHT ENCOUNTER BUGS ON THE LATEST MINECRAFT VERSION AND PAPER WILL NOT GIVE YOU SUPPORT ON ANY PREVIOUS VERSIONS, OTHER THAN THE LATEST"
    sleep 5
    echo "${GREEN}what version of minecraft so you want?${NC}"
    read version
    name=paper
    api=https://api.papermc.io/v2
    latest_build="$(curl -sX GET "$api"/projects/"$name"/versions/"$version"/builds -H 'accept: application/json' | jq '.builds [-1].build')"
    revision="$(curl -sX GET "$api"/projects/"$name"/version_group/"$version"/builds -H 'accept: application/json' | jq -r '.builds [-1].version')"
    filename="$(curl -sX GET "$api"/projects/"$name"/version_group/"$version"/builds -H 'accept: application/json' | jq -r '.builds [-1].downloads.application.name')"
    download_url="$api"/projects/"$name"/versions/"$revision"/builds/"$latest_build"/downloads/"$filename"
    wget "$download_url"