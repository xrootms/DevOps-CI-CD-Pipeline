# Jenkins RBAC Setup (Industry Standard)

This guide explains how to create a namespace-scoped ServiceAccount,
Role, RoleBinding, and Token for Jenkins using Kubernetes RBAC best
practices.

This setup follows **industry-standard least-privilege principles**,
giving Jenkins access only within the `webapps` namespace.

------------------------------------------------------------------------

## AML File: `jenkins-rbac.yaml`

Apply all resources using one combined manifest:

``` yaml
(apiVersion YAML omitted for brevity in this preview)
```

(Use the full YAML from your canvas document.)

------------------------------------------------------------------------

## Apply the RBAC Resources

Run:

``` bash
kubectl apply -f jenkins-rbac.yaml
```

------------------------------------------------------------------------

## 🔍 View the Secret Details

### Option 1 --- Describe the secret

``` bash
kubectl -n webapps describe secret jenkins-token
```

### Option 2 --- View full YAML

``` bash
kubectl -n webapps get secret jenkins-token -o yaml
```

------------------------------------------------------------------------

## Extract the ServiceAccount Token

``` bash
kubectl -n webapps get secret jenkins-token -o jsonpath='{.data.token}' | base64 -d
```

This will print the **token string** that Jenkins will use for
authentication.

------------------------------------------------------------------------

## Final Step --- Add Token to Jenkins

Go to:

**Jenkins → Manage Jenkins → Manage Credentials → Add Credential**

Choose: - **Kind:** Secret Text (or Kubernetes Bearer Token depending on
plugin) - **Secret:** *paste the extracted token* - **ID:**
`k8s-jenkins-token`

------------------------------------------------------------------------

## Summary

-   Namespace `webapps` created\
-   Jenkins ServiceAccount created\
-   Role with least-privilege permissions\
-   RoleBinding applied\
-   Token generated manually (Kubernetes 1.24+ behavior)\
-   Token used for Jenkins Kubernetes integration

