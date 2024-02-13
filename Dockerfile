FROM registry.access.redhat.com/ubi9/go-toolset:latest AS builder
COPY . .

ENV GOFLAGS=-buildvcs=false
RUN git config --global --add safe.directory /opt/app-root/src && \
    make prepare_release
ENV REL_VER=$REL_VER
FROM registry.access.redhat.com/ubi9/ubi-micro:latest
LABEL description="Terraform Provider RHCS"
LABEL io.k8s.description="Terraform Provider RHCS"
LABEL com.redhat.component="terraform-provider-rhcs"
LABEL distribution-scope="release"
LABEL name="terraform-provider-rhcs" release="${REL_VER}" url="https://github.com/enriquebelarte/terraform-provider-rhcs"
LABEL vendor="Red Hat, Inc."
LABEL version="${REL_VER}"

COPY --from=builder /opt/app-root/src/releases /releases
