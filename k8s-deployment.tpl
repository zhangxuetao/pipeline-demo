apiVersion: apps/v1
kind: Deployment
metadata:
  name: {APP_NAME}-deployment
  labels:
    app: {APP_NAME}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {APP_NAME}
  template:
    metadata:
      labels:
        app: {APP_NAME}
    spec:
      containers:
      - name: {APP_NAME}
        image: {IMAGE_URL}:{IMAGE_TAG}
        ports:
        - containerPort: 40080
        env:
          - name: SPRING_PROFILES_ACTIVE
            value: {SPRING_PROFILE}
---
apiVersion: v1
kind: Service
metadata:
  name: {APP_NAME}-service
  labels:
    app: {APP_NAME}
spec:
  type: NodePort
  selector:
    app: {APP_NAME}
  ports:
  - name: {APP_NAME}
    port: 40080
    targetPort: 40080
    nodePort: 30050
