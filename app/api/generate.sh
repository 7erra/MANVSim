docker run --rm -v ${PWD}:/local openapitools/openapi-generator-cli generate -i /local/spec.yml -g dart -o /local/generated -c /local/config.json