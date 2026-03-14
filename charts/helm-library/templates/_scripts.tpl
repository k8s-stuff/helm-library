{{- define "helm-lib.scripts.combine-certs" -}}
cat {{include "helm-lib.values.ca-bundle-path" .}}/{{include "helm-lib.values.ca-bundle-file-name" .}} /mnt/authorities/* > /mnt/ca-certs/{{include "helm-lib.values.ca-bundle-file-name" .}}
{{- end}}
