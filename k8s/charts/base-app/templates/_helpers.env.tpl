{{- define "base-app.envFromValues" }}
{{- with .Values.env }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "base-app.envFromSecrets" }}
{{- range $name, $secret := .Values.secrets.env }}
- name: {{ required "secrets.env.*.envVarName is required" $secret.envVarName }}
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s-%s" (include "base-app.name" $) $name }}
      key: {{ required "secrets.env.*.remoteRef.property is required" $secret.remoteRef.property }}
{{- end }}
{{- end }}
