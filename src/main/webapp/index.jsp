<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>DevOps Tools</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f4f9;
      margin: 0;
      padding: 0;
    }
    header {
      background: #2c3e50;
      color: white;
      text-align: center;
      padding: 20px 0;
    }
    h1 {
      margin: 0;
    }
    .container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      padding: 20px;
    }
    .card {
      background: white;
      border-radius: 10px;
      padding: 15px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.2s ease-in-out;
    }
    .card:hover {
      transform: scale(1.05);
    }
    .category {
      font-size: 14px;
      color: #555;
      text-transform: uppercase;
      margin-bottom: 8px;
    }
    .tools {
      font-size: 16px;
      font-weight: bold;
      color: #2c3e50;
    }
  </style>
</head>
<body>

  <header>
    <h1>Popular DevOps Tools</h1>
  </header>

  <div class="container">
    <div class="card">
      <div class="category">Version Control</div>
      <div class="tools">Git, GitHub, GitLab, Bitbucket</div>
    </div>

    <div class="card">
      <div class="category">CI/CD</div>
      <div class="tools">Jenkins, GitHub Actions, GitLab CI, CircleCI</div>
    </div>

    <div class="card">
      <div class="category">Configuration Management</div>
      <div class="tools">Ansible, Puppet, Chef</div>
    </div>

    <div class="card">
      <div class="category">Containers</div>
      <div class="tools">Docker, Podman</div>
    </div>

    <div class="card">
      <div class="category">Orchestration</div>
      <div class="tools">Kubernetes, OpenShift</div>
    </div>

    <div class="card">
      <div class="category">Cloud Platforms</div>
      <div class="tools">AWS, Azure, GCP</div>
    </div>

    <div class="card">
      <div class="category">Monitoring</div>
      <div class="tools">Prometheus, Grafana, ELK Stack</div>
    </div>

    <div class="card">
      <div class="category">Infrastructure as Code</div>
      <div class="tools">Terraform, CloudFormation</div>
    </div>
  </div>

</body>
</html>
