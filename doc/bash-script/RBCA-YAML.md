apiVersion: v1
kind: Namespace
metadata:
  name: webapps
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins
  namespace: webapps
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: jenkins-deployer
  namespace: webapps
rules:
  - apiGroups: ["", "apps", "batch"]
    resources:
      - pods
      - pods/log
      - deployments
      - replicasets
      - services
      - configmaps
      - secrets
    verbs:
      - get
      - list
      - watch
      - create
      - update
      - patch
      - delete
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: jenkins-deployer-binding
  namespace: webapps
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: jenkins-deployer
subjects:
  - kind: ServiceAccount
    name: jenkins
    namespace: webapps
---
apiVersion: v1
kind: Secret
metadata:
  name: jenkins-token
  namespace: webapps
  annotations:
    kubernetes.io/service-account.name: jenkins
type: kubernetes.io/service-account-token
