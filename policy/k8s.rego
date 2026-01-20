package main

import future.keywords.contains
import future.keywords.if

# Regla 1: Evitar correr como root
deny contains msg if {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  not c.securityContext.runAsNonRoot
  msg := sprintf("El contenedor '%v' debe tener securityContext.runAsNonRoot=true", [c.name])
}

# Regla 2: Evitar escalada de privilegios
deny contains msg if {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  c.securityContext.allowPrivilegeEscalation == true
  msg := sprintf("El contenedor '%v' no debe permitir escalada de privilegios", [c.name])
}

# Regla 3: No usar etiqueta 'latest'
deny contains msg if {
  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  endswith(image, ":latest")
  msg := sprintf("La imagen '%v' usa la etiqueta ':latest', no permitido en prod", [image])
}