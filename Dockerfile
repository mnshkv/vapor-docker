FROM mnshkv/swift-arm

WORKDIR /build

COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# Build everything, with optimizations
RUN swift build -c release

# Switch to the staging area
# WORKDIR /staging

# # Copy main executable to staging area
# RUN cp "$(swift build --package-path /build -c release --show-bin-path)/Run" ./

# # Copy any resouces from the public directory and views directory if the directories exist
# # Ensure that by default, neither the directory nor any of its contents are writable.
# RUN [ -d /build/Public ] && { mv /build/Public ./Public && chmod -R a-w ./Public; } || true
# RUN [ -d /build/Resources ] && { mv /build/Resources ./Resources && chmod -R a-w ./Resources; } || true

# # Create a vapor user and group with /app as its home directory
# RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app vapor

# # Switch to the new home directory
# WORKDIR /app

# # Copy built executable and any staged resources from builder
# COPY --from=build --chown=vapor:vapor /staging /app

# # Ensure all further commands run as the vapor user
# USER vapor:vapor

# # Let Docker bind to port 8080
# EXPOSE 8080

# # Start the Vapor service when the image is run, default to listening on 8080 in production environment
# ENTRYPOINT ["./Run"]
# CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
