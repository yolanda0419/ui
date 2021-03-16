cp home.adoc  documents/docs/PSP_Installation_Deployment_Manual/modules/ROOT/pages/

antora --fetch antora-playbook.yml

cd documents/docs

find . -name "images" -exec dirname {} \; | cut -c3- | while read image; do
  cp -r $image/images  ${image%/*} 
done

find . -name "index.adoc" -exec dirname {} \; | cut -c3- | while read var; do
  docker run -v $PWD/$var:/docs 10.0.1.58:5555/tools/asciidoctor:latest
  cp -v $PWD/${var%%/*}/modules/ROOT/pages/index.pdf  ../../build/site/${var%%/*}

done
