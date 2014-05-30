#!/bin/bash
curl '192.168.10.10:9200/get-together/_search' -d '{
	"query": {
		"match": {
			"organizer": "Lee"
		}
	},
	"from": 10,
	"size": 10
}'