brew tap anchore/grype     
brew install grype      

brew tap aquasecurity/trivy                     
brew install trivy


docker build -f ./Dockerfile.app -t oyelowo/vulnapp

grype oyelowo/vulnapp --scope all-layers 
 
trivy image oyelowo/vulnapp
