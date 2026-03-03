{{- define "helm-lib.values.service.type" -}}
{{- (.Values.service).type | default "ClusterIP" }}
{{- end }}

{{- define "helm-lib.values.service.port" -}}
{{- (.service).port | default ((.Values).service).port | default 80 }}
{{- end }}

{{- define "helm-lib.values.service.targetPort" -}}
{{- (.service).targetPort | default ((.Values).service).targetPort | default 8080 }}
{{- end }}

{{- define "helm-lib.values.service.targetScheme" -}}
{{- (.service).targetScheme | default ((.Values).service).targetScheme | default "HTTP" }}
{{- end }}

{{- define "helm-lib.values.application.configPath" -}}
{{- (.Values.application).configPath | default "/app" | trimSuffix "/" }}
{{- end }}

{{- define "helm-lib.values.configFileName" -}}
{{- if (.Values.application).configFileName }}
{{- .Values.application.configFileName | trimSuffix ".json" }}.json
{{- else }}
{{- include "helm-lib.name" . }}.settings.json
{{- end }}
{{- end }}

{{- define "helm-lib.values.ca-bundle-path" -}}
/etc/ssl/certs
{{- end }}

{{- define "helm-lib.values.ca-bundle-file-name" -}}
ca-certificates.crt
{{- end }}

{{- define "helm-lib.values.tls.mountPath" -}}
{{- (.Values.tls).mountPath | default "/mnt/tls" }}
{{- end }}

{{- define "helm-lib.values.affinity" -}}
podAntiAffinity:
  preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 50
      podAffinityTerm:
        topologyKey: "kubernetes.io/hostname"
        labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values:
            - {{ include "helm-lib.name" . }}
{{- end }}