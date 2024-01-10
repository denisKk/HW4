MODULE="Modules/ClevelandMuseumNetworking/Sources/ClevelandMuseumNetworking"

openapi-generator generate -i "Specifications/CleverlandMuseumSpecification.yml" -g swift5 -o "CleverlandMuseumApi"
rm -r $MODULE""*
cp -R "CleverlandMuseumApi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "CleverlandMuseumApi"
