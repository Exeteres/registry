# buildpack-deps:24.04 (as of 2024-06-16)
FROM buildpack-deps@sha256:9f35d074ab95834d6be3e55f54306ebe6bc53bf79e68601b46a8ba7f8cd4adfd

# Rename ubuntu user to dev
RUN usermod -l dev ubuntu && \
    groupmod -n dev ubuntu && \
    usermod -d /home/dev -m dev
