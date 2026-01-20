# Borrador de Informe Técnico: Implementación DevSecOps

## 1. Arquitectura

Para este proyecto se ha seleccionado una arquitectura moderna y eficiente basada en microservicios, utilizando las siguientes tecnologías clave:

*   **FastAPI:** Se eligió este framework de Python por su alto rendimiento, soporte nativo para programación asíncrona y validación automática de datos. Facilita la creación de APIs robustas y rápidas, ideales para entornos de microservicios.
*   **Docker:** La contenerización mediante Docker garantiza la portabilidad y consistencia del entorno de ejecución. Permite empaquetar la aplicación con todas sus dependencias, eliminando problemas de compatibilidad entre entornos de desarrollo, prueba y producción.
*   **Kubernetes / Kind:** Kubernetes es el estándar de facto para la orquestación de contenedores, proporcionando escalabilidad y gestión automatizada. Para el desarrollo local, se utilizó **Kind (Kubernetes in Docker)**, que permite simular un clúster de Kubernetes completo utilizando contenedores Docker como nodos, facilitando pruebas de despliegue realistas sin necesidad de infraestructura en la nube costosa.

## 2. Pipeline CI/CD

Se ha implementado un flujo de Integración y Despliegue Continuo (CI/CD) utilizando **GitHub Actions**, definido en el archivo `.github/workflows/ci-cd.yaml`. El pipeline se activa automáticamente ante cambios en la rama `main` y consta de tres trabajos principales ejecutados en paralelo/secuencia:

1.  **Build:** Se encarga de preparar el entorno, instalar dependencias y construir la imagen Docker de la aplicación, asegurando que el código sea empaquetable y desplegable.
2.  **Test:** Ejecuta las pruebas unitarias utilizando `pytest` para verificar la funcionalidad del código y asegurar que los nuevos cambios no introduzcan regresiones.
3.  **Security:** Integra prácticas de seguridad desde el inicio (Shift-Left) ejecutando análisis estático de código (SAST) con `bandit` para detectar vulnerabilidades comunes en el código Python.

## 3. Seguridad (DevSecOps)

La seguridad se ha integrado como un componente fundamental del ciclo de desarrollo. Se generaron las siguientes evidencias:

*   **Análisis Estático (SAST):** El reporte generado por **Bandit** (`evidencias/reporte_sast.txt`) indica que **no se identificaron problemas de seguridad** en el código escaneado. Esto valida que el código fuente actual cumple con las prácticas básicas de seguridad para Python y no contiene vulnerabilidades de severidad alta, media o baja detectables por la herramienta.
*   **Cumplimiento de Políticas (IaC):** Se utilizó **Conftest** para validar los manifiestos de Kubernetes contra políticas de seguridad (`evidencias/reporte_politicas.txt`). La ejecución finalizó sin reportar fallos, lo que sugiere que los manifiestos evaluados cumplen con las reglas definidas (o que se requiere ampliar la cobertura de políticas para futuros análisis más exhaustivos).

## 4. Conclusiones

1.  **Automatización y Eficiencia:** La implementación del pipeline CI/CD automatiza tareas críticas como pruebas y construcción, reduciendo el error humano y acelerando el tiempo de entrega de software al producción.
2.  **Seguridad Integrada:** La adopción de la metodología DevSecOps mediante herramientas como Bandit y Conftest permite identificar y remediar vulnerabilidades en etapas tempranas del desarrollo, reduciendo significativamente el riesgo y el coste de corrección.
3.  **Portabilidad y Escalabilidad:** El uso de Docker y Kubernetes asegura que la aplicación pueda desplegarse de manera consistente en cualquier entorno, desde la máquina local del desarrollador hasta clústeres de producción a gran escala, facilitando el crecimiento futuro del proyecto.
