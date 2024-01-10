MODULE="Modules/HarvardArtMuseumsNetworking/Sources/HarvardArtMuseumsNetworking"

openapi-generator generate -i "Specifications/HarvardArtMuseumSpecification.yml" -g swift5 -o "HarvardArtMuseumsApi"
rm -r $MODULE""*
cp -R "HarvardArtMuseumsApi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "HarvardArtMuseumsApi"
