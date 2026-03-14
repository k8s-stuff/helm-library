{{- define "helm-lib.deployment.secret-authorities" -}}
{{- if (.Values.initContainer).caBundleEnabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "helm-lib.secret-authorities" . }}
  annotations:
    helm.sh/hook: pre-upgrade, pre-install
    helm.sh/hook-weight: "-20"
data:
{{- range $key, $value:= (required "List of trusted certification authorities is required!" (.Values.application).trustedCertificateAuthorities) }}
  {{$key}}: {{$value}}
{{- end }}
{{- end }}
{{- end }}
