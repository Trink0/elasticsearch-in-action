#!/bin/bash
ES_HOST="192.168.10.10"

echo "###############"
echo "Query Filtered Group Match All"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"filtered":{
			"query": {
				"match_all": { }
			}
		}
	}
}'
echo

echo "###############"
echo "Query Filtered Group description"
echo "###############"
curl $ES_HOST':9200/get-together/group/_search' -d '{
	"query": {
		"filtered":{
			"query": {
				"match": {
					"description": "together"
				}
			}
		}
	}
}'
echo

echo "###############"
echo "Query Filtered Group description with additional filter on tag"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"filtered": {
			"query": {
				"match": {
					"description": "together"
				}
			},
			"filter": {
				"term": {
					"tags": "clojure"
				}
			}
		}
	}
}'
echo

echo "###############"
echo "Query Filtered Group match_all with filter on tag or description"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"filtered": {
			"query": {
				"match_all": {}
			},
			"filter": {
				"term": {
					"tags": "clojure",
					"description": "together"
				}
			}
		}
	}
}'
echo

echo "###############"
echo "Query Filtered Group match_all with boolean AND filter on tag and description"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"filtered": {
			"query": {
				"match_all": {}
			},
			"filter": {
				"bool": {
					"must": [
						{
							"term": {
								"tags": "clojure"
							}
						},
						{
							"term": {
								"description": "together"
							}	
						}		
					]
				}
				
			}
		}
	}
}'
echo

echo "###############"
echo "Query Terms Group on tags"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"terms": {
			"tags": ["jvm", "hadoop"]
		}
	}
}'
echo

echo "###############"
echo "Query Terms Group on tags with minimum match"
echo "###############"
curl $ES_HOST':9200/get-together/_search' -d '{
	"query": {
		"terms": {
			"tags": ["jvm", "hadoop", "java"],
			"minimum_match": 2
		}
	}
}'
echo
