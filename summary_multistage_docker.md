Project Setup

Created project folder:

mkdir multistage
cd multistage

Initialized Go module:

go mod init myapp
go mod tidy

Confirm Go installation:

go version

Dockerfile Overview

Stage 1 (Builder):

Builds the Go application in /build directory.

Uses Go Alpine image.

Runs go mod download and builds a fully static binary.

Stage 2 (Final/Distroless):

Smallest possible image.

Copies the compiled binary from builder.

Runs as nonroot.

No shell, logs must be application-level.

Optional Single-Stage Image:

Larger, easier for debugging.

Includes Go runtime and all dependencies.

3️⃣ Building Docker Images

Build final distroless image:

docker build -t go-multistage-app --target final .


Debug image (full Go, logs available):

docker build -t go-debug-app .
docker run -p 8080:8080 go-debug-app
docker logs <container-id>


Key points / errors observed:

Issue	Cause	Solution
Target stage final not found	Stage name mismatch	Check Dockerfile stage names
go: requires go >= 1.24.4	Builder image had old Go version	Update builder image to match Go version
Distroless container has no shell	Minimal image, intentionally	Use debug image for shell access
Logs not visible in distroless	No shell / stdout logging	Add app-level logging to stdout/stderr
4️⃣ Running the Container
docker run -p 8080:8080 go-multistage-app
curl http://localhost:8080


Distroless container → silent terminal, cannot access shell.

Debug container → visible logs, easier to troubleshoot.

5️⃣ GitHub Integration

Copied multistage folder into local repo:

cp -r /home/ec2-user/multistage /home/ec2-user/Devops/
git add multistage/
git commit -m "Add Go multistage Docker project"


If push is rejected due to remote commits:

git pull origin main --rebase
git push origin main


Notes:

Repo stores source code + Dockerfile, not Docker images.

Minimal image should not be pushed to GitHub directly.

6️⃣ CI/CD – GitHub Actions Workflow (Optional)

Automatically build and push Docker images on main branch pushes.

Example steps:

Checkout repo.

Set up Docker Buildx.

Log in to GitHub Container Registry.

Build & push image (ghcr.io/<username>/go-multistage-app:latest).

Workflow does not store image in repo, only in container registry.

Free-tier friendly.

7️⃣ Integration Ideas

Kubernetes Deployment:

Use EKS, GKE, or local Minikube to deploy the Docker image.

Pull the image from GHCR or other registry.

Multistage + static binary → small pods, faster startup.

Pipeline Integration:

GitHub Actions → build + test + push image.

Jenkins/CodePipeline → can pull from GitHub and push to ECR.

Distroless images → production-ready minimal containers.

8️⃣ Key Takeaways

Multistage builds → small final image, debug image for development.

Fully static binary → portable, no runtime dependencies.

GitHub repo → only source code + Dockerfile.

Docker images → push to container registry (GHCR, Docker Hub, AWS ECR).

Troubleshooting tips: Go versions, stage names, container logs, Git pull/push sync.
