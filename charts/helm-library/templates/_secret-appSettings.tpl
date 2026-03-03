{{- define "helm-lib.deployment.secret-app-settings" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helm-lib.secret-app-settings" . }}
  annotations:
    helm.sh/hook: pre-upgrade, pre-install
    helm.sh/hook-weight: "-20"
data:
  {{ include "helm-lib.values.configFileName" . }}: {{ (tpl (toYaml (.Values.appSettings | default dict )) .) | fromYaml | toPrettyJson | b64enc }}
{{- end }}
