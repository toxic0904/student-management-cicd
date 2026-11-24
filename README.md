# Student Management System — CI/CD Mini Project

## 1. Project overview
This mini project is a simple Java web application to maintain student records. It demonstrates the requested DevOps flow:

**Java application → Git repository → Maven build/test → Jenkins pipeline → Docker image → running container**

## 2. Features
- Add a student with name, email and course.
- View all saved student records.
- Delete a student record.
- REST API for student operations.
- H2 in-memory database (records reset when the application restarts).

## 3. Technologies
| Technology | Purpose |
|---|---|
| Java 17 + Spring Boot | Web application and REST API |
| Maven | Dependency management, build and tests |
| Git | Source-code version control |
| Jenkins | CI/CD automation |
| Docker | Container image and deployment |
| H2 | Lightweight in-memory database |

## 4. Run locally (before using Jenkins)
Requirements: JDK 17 and Maven 3.9 or later.

1. Extract the ZIP file.
2. Open the extracted `student-management-cicd` folder in VS Code.
3. Open Terminal → New Terminal.
4. Run: `mvn clean test package`
5. Run: `mvn spring-boot:run`
6. Open `http://localhost:8080` in a browser.

The REST API is available at `http://localhost:8080/api/students`.
H2 console: `http://localhost:8080/h2-console` (JDBC URL: `jdbc:h2:mem:studentsdb`, user: `sa`, password blank).

## 5. Git repository setup
Run these commands from the project folder:

```bash
git init
git add .
git commit -m "Initial Student Management System"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

Create an empty repository on GitHub first, then replace `YOUR_GITHUB_REPOSITORY_URL` with its actual URL.

## 6. Docker: build and run manually
Make sure Docker Desktop is running.

```bash
docker build -t student-management:latest .
docker run -d --name student-management-app -p 8080:8080 student-management:latest
```

Open `http://localhost:8080`. To stop and remove the container:

```bash
docker rm -f student-management-app
```

## 7. Jenkins pipeline setup
The included `Jenkinsfile` performs four stages:
1. **Checkout** — gets source code from the configured Git repository.
2. **Build and Test** — runs `mvn clean test package`.
3. **Build Docker Image** — builds a versioned image using the Jenkins build number and tags it as `latest`.
4. **Deploy Container** — replaces the previous container and starts the new one on port 8080.

### Jenkins prerequisites
- A Jenkins installation with a working agent.
- JDK 17 and Maven configured in **Manage Jenkins → Tools** with names exactly `JDK17` and `Maven`, matching the Jenkinsfile.
- Docker installed and available to the Jenkins agent user.
- A Jenkins Pipeline job configured to use this Git repository and the `Jenkinsfile`.

If your Jenkins installation uses different tool names, update the names in the `tools` section. The agent must have permission to run Docker commands. The deployment stage assumes the Jenkins agent can publish port 8080 on the machine where the container runs.

## 8. Pipeline flow
```text
Developer
   |
   v
Git push
   |
   v
Jenkins: Checkout
   |
   v
Maven: Build + Test
   |
   v
Docker: Build image
   |
   v
Docker: Run container
   |
   v
Student Management web app (port 8080)
```

## 9. Demo checklist
- [ ] Run the application locally.
- [ ] Add two student records in the browser.
- [ ] Delete one record.
- [ ] Push the project to GitHub.
- [ ] Configure Jenkins tools and a Pipeline job.
- [ ] Run the Jenkins job and show the successful stages.
- [ ] Show the Docker image with `docker images`.
- [ ] Show the running container with `docker ps`.
- [ ] Open the deployed application at `http://localhost:8080`.

## 10. Limitations and future scope
- H2 is in-memory; use MySQL or PostgreSQL for persistent storage.
- Add edit/update controls, validation, login and role-based access.
- Push images to Docker Hub or a private registry.
- Add HTTPS, environment-based configuration and automated deployment to a server.

## 11. Important note
This is an educational local/demo pipeline. It does not include production secrets management, registry authentication, HTTPS, database persistence or cloud deployment. Configure those before using it outside a classroom environment.


## Updated Campusly dashboard UI

The default page at `http://localhost:8080` is now a responsive multi-section dashboard:
- Overview home page with student and course statistics
- All Students directory with search and course filter
- Add and edit student modal, plus delete confirmation
- Course overview generated from live student records

The UI uses the existing `/api/students` REST endpoints. No additional backend dependencies are required.
