#!/bin/bash
ES_HOST="192.168.10.10"

echo "###############"
echo "Query Match host"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"match": {
			"host": "Lee"
		}
	}
}'
echo

echo "###############"
echo "Query Match with cursor starting from 3"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"match": {
			"host": "Lee"
		}
	},

	"from": 3,
	"size": 10
}'
echo

echo "###############"
echo "Query Match with cursor starting from 3, returning only Name and description fields"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"match": {
			"host": "Lee"
		}
	},
	"fields": ["name", "description"],

	"from": 3,
	"size": 10
}'
echo