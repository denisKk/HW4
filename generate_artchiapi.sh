MODULE="Modules/ArtInstituteChicagoNetworking/Sources/ArtInstituteChicagoNetworking"

openapi-generator generate -i "Specifications/ArtInstituteChicagoSpecification.yml" -g swift5 -o "ArtInstituteChicagoApi"
rm -r $MODULE""*
cp -R "ArtInstituteChicagoApi/OpenAPIClient/Classes/OpenAPIs/". $MODULE
rm -r "ArtInstituteChicagoApi"
