{{- define "cka-web.name" -}}
{{- .Chart.Name -}}
{{- end -}}
{{- define "cka-web.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
