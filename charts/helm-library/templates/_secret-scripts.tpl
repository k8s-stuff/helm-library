{{- define "helm-lib.deployment.secret-scripts" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helm-lib.secret-scripts" . }}
  annotations:
    helm.sh/hook: pre-upgrade, pre-install
    helm.sh/hook-weight: "-20"
data:
  combine-certs.sh: {{ (include "helm-lib.scripts.combine-certs" .) | replace "\r\n" "\n" | b64enc }}
{{- end }}
