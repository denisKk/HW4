MODULE="Modules/RISDMuseumNetworking/Sources/RISDMuseumNetworking"

openapi-generator generate -i "Specifications/RISDMuseumSpecification.yml" -g swift5 -o "RISDMuseumAPI"
rm -r $MODULE""*
cp -R "RISDMuseumAPI/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "RISDMuseumAPI"
