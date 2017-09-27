# cwl-inspector
[![Build Status](https://travis-ci.org/tom-tan/cwl-inspector.svg?branch=master)](https://travis-ci.org/tom-tan/cwl-inspector)

cwl-inspector provides a handy way to inspect properties of tools or workflows written in Common Workflow Language

# Requirements
- Ruby 2.4.1 or later

# Running examples

Input: echo.cwl
```yaml
class: CommandLineTool
cwlVersion: v1.0
id: echo_cwl
baseCommand:
  - cowsay
inputs:
  - id: input
    type: string?
    inputBinding:
      position: 0
    label: Input string
    doc: This is an input string
outputs:
  - id: output
    type: string?
    outputBinding: {}
requirements:
  - class: DockerRequirement
    dockerPull: docker/whalesay
```

## show a property named 'cwlVersion'
```console
$ ./cwl-inspector.rb echo.cwl .cwlVersion
v1.0
```

## show a nested property
```console
$ ./cwl-inspector.rb echo.cwl .requirements.0.class
DockerRequirement
```

You can access an input parameter by using its index (specified by `position` field) or its id.

```console
$ ./cwl-inspector.rb echo.cwl .inputs.0.label
Input string
```

or

```console
$ ./cwl-inspector.rb echo.cwl .inputs.input.label
Input string
```

## show keys in the specified property
```console
$ ./cwl-inspector.rb echo.cwl 'keys(.)'
class
cwlVersion
id
baseCommand
inputs
outputs
requirements
```

## show the command to run a given cwl file
```console
$ ./cwl-inspector.rb echo.cwl commandline
docker run -i --rm docker/whalesay cowsay [ $input ]
```

You can also specify the parameter to show the command with instantiated parameters.
```console
$ ./cwl-inspector.rb echo.cwl commandline -- --input Hello!
docker run -i --rm docker/whalesay cowsay Hello!
```

# Dockerized cwl-inspector
You can use [`ttanjo/cwl-inspector`](https://hub.docker.com/r/ttanjo/cwl-inspector/) image.
This image is built by [Travis CI](https://travis-ci.org/tom-tan/cwl-inspector).

```console
$ cat echo.cwl | docker run --rm -i ttanjo/cwl-inspector - .cwlVersion
v1.0
```

# License
This software is released under the [MIT License](https://github.com/tom-tan/cwl-inspector/blob/master/LICENSE).

The following file in `examples` is copied from [common-workflow-language/common-workflow-language](https://github.com/common-workflow-language/common-workflow-language) and is released under [Apache 2.0 License](https://github.com/common-workflow-language/common-workflow-language/blob/master/LICENSE.txt).
- `examples/expression.cwl` ([Source in common-workflow-language/common-workflow-language](https://github.com/common-workflow-language/common-workflow-language/blob/master/v1.0/examples/expression.cwl))
