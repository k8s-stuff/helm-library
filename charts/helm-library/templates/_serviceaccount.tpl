{{- define "helm-lib.deployment.serviceAccount" -}}
{{- if ((.Values.serviceAccount).create) -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "helm-lib.serviceAccountName" . }}
  annotations:
    helm.sh/hook: pre-upgrade, pre-install
    helm.sh/hook-weight: "-20"
  labels:
    {{- include "helm-lib.labels" . | nindent 4 }}
    {{- with (.Values.serviceAccount).annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
automountServiceAccountToken: {{ (.Values.serviceAccount).automount | default true }}
{{- end }}
{{- end }}
