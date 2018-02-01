#!/usr/bin/env node
var got = require('got');

console.log('Calling Travis...');

var slug = "kevinwlau%2Fopenliberty.io";

got.post(`https://api.travis-ci.org/repo/${slug}/requests`, {
    headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Travis-API-Version": "3",
        "Authorization": `token ${process.env.TRAVIS_API_TOKEN}`,
    },
    body: JSON.stringify({
        request: {
        message: `Override commit: ${process.env.TRAVIS_COMMIT_MESSAGE}`,
        branch: 'source',
        },
    }),
})
.then(() => {
    console.log("Triggered build of openliberty");
})
.catch((err) => {
    console.error(err);

    process.exit(-1);
});
