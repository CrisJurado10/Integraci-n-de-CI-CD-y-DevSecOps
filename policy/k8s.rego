package k8ssecurity

deny[msg] {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  not c.securityContext.runAsNonRoot
  msg := "Container must set securityContext.runAsNonRoot=true"
}

deny[msg] {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  c.securityContext.allowPrivilegeEscalation
  msg := "Container must set allowPrivilegeEscalation=false"
}
