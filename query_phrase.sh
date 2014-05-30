#!/bin/bash
ES_HOST="192.168.10.10"

echo "###############"
echo "Query Match Boolean Behaviour"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"query": "elasticsearch denver",
				"operator": "and"
			}
		}
	}
}'
echo

echo "###############"
echo "Query Match Phrase slop 1"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"type": "phrase",
				"query": "enterprise london",
				"slop": 1
			}
		}
	}
}'
echo


echo "###############"
echo "Query Match Phrase slop 2 finds id document 5"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"type": "phrase",
				"query": "enterprise get-together",
				"slop": 2
			}
		}
	}
}'
echo

echo "###############"
echo "Query Match Phrase slop 1 DONT find id document 5"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"type": "phrase",
				"query": "enterprise get-together",
				"slop": 1
			}
		}
	}
}'
echo

echo "###############"
echo "Query Match Phrase Prefix (usefull for autocomplete)"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"type": "phrase_prefix",
				"query": "elasticsearch den",
				"max_expansions": 1
			}
		}
	},
	"fields": ["name"]
}'
echo

echo "###############"
echo "Query Match Phrase Prefix only first letters DOESNT return data"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"match":{
			"name": {
				"type": "phrase_prefix",
				"query": "elastic",
				"max_expansions": 1
			}
		}
	},
	"fields": ["name"]
}'
echo

echo "###############"
echo "Query Match Prefix first letters (usefull for autocomplete)"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"filtered":{
			"query": {
				"match_all": {}
			},
			"filter": {
				"prefix": {
					"name": "elas"
				}
			}
		}
	},
	"fields": ["name"]
}'
echo

echo "###############"
echo "Query Wildcard to match part of word in a field"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"wildcard":{
			"description": {
				"wildcard": "opp*"
			}
		}
	},
	"fields": ["description"]
}'
echo