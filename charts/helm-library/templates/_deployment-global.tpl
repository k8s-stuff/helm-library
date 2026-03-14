{{- define "helm-lib.deployment.global" -}}
{{include "helm-lib.deployment.deploy" . }}
---
{{ include "helm-lib.deployment.secret-tls" . }}
---
{{ include "helm-lib.deployment.secret-scripts" . }}
---
{{ include "helm-lib.deployment.secret-authorities" . }}
---
{{include "helm-lib.deployment.secret-env" . }}
---
{{include "helm-lib.deployment.secret-app-settings" . }}
---
{{include "helm-lib.deployment.hpa" . }}
---
{{include "helm-lib.deployment.ingress" . }}
---
{{include "helm-lib.deployment.service" . }}
---
{{include "helm-lib.deployment.externalsecret" . }}
---
{{include "helm-lib.deployment.secretstore" . }}
---
{{include "helm-lib.deployment.serviceAccount" . }}
---
{{include "helm-lib.deployment.servicemonitor" . }}
{{- end }}
