# Wave Operator

Helm chart to deploy the Wave Operator

This chart is usually invoked by the [spotcl](https://github.com/spotinst/spotctl) tool, 
but may also be run manually.

## Requirements

| Repository                        | Name           | Version |
| --------------------------------- | -------------- | ------- |
| "https://charts.jetstack.io"      | cert-manager   | 1.0.4+  |

Cert Manager *must* be installed before the Wave Operator, as several compoenents depend on
certificate request. It is not necessary to use the cert-manager helm chart, if some
other installation method is preferred.

## Values

The default values should be satisfactory in every case. Documentation will be added here
when additional configuration proves necessary.

## Installation

1. Add the chart repository:

```sh
$ helm repo add spot https://charts.spot.io
```

2. Update information of available charts:

```sh
$ helm repo update
```

3. Install Cert Manager

Use one of the methds described in the [documentation](https://cert-manager.io/docs/installation/kubernetes/)

4. Install the Wave Operator:

```sh
$ helm install wave-operator spot/wave-operator
```

## Development

Because the wave operator is highly dependent on cert manager, it's not currently possible
to run the automatic github actions using the [ct](https://github.com/helm/chart-testing)
tool. Therefore, upgrades to this chart should be tested very carefully outside of the
CI process.

