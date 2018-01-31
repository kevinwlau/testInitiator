if [ ! -z $GITHUB_TRAVIS_TOKEN ]; then
    echo "Start requesting a travis build from upstream repository...";
    # Doesn't use --debug on `travis login`.  --debug will show the github token
    export TRAVIS_ACCESS_TOKEN=`travis login --skip-completion-check --org --github-token "$GITHUB_TRAVIS_TOKEN" && travis token`;
    UPSTREAM_REPO_SLUG="kevinwlau%2Fopenliberty.io"
    echo $TRAVIS_COMMIT_MESSAGE
    body='{
      "request": {
      "message": "Override from testInitiator commit: "' + $TRAVIS_COMMIT_MESSAGE + ',
      "branch":"test"
      }}'
    curl -s -S -f -X POST \
      -H "Content-Type: application/json" \
      -H "Accept: application/json" \
      -H "Travis-API-Version: 3" \
      -H "Authorization: token $TRAVIS_ACCESS_TOKEN" \
      -d "$body" \
      https://api.travis-ci.org/repo/$UPSTREAM_REPO_SLUG/requests
      
      echo "SUCCESS: Completed request for travis build from upstream repository...";
  else
    echo "ERROR: Missing Github token.  Cannot request a travis build for upstream repository...";
  fi
sudo: false # route your build to the container-based infrastructure for a faster build