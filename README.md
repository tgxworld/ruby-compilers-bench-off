# Steps to Run Scripts (Within Bare Metal Server Shell)

### 1. Build Image for Rubies Compiled with Various Compilers

```bash
cd compiled_ruby_base
sudo docker build -t tgxworld/ruby_compilers_base .
```

### 2. Build Image for Running Ruby Benchmarks with Compiled Rubies

```bash
cd ruby_bench
sudo docker build -t tgxworld/ruby_compilers_bench .
```

### 3. Run Ruby Benchmarks and Copy Results

```bash
sudo docker run tgxworld/ruby_compilers_bench
sudo docker cp <Container ID>:/ruby/benchmark/compilers_results /compilers_results
```

### 4. Generate Percentage Report for Ruby Benchmarks
```bash
cd /compilers_results
ruby compile_results.rb
ruby calculate_percentage_base_line.rb
```

### 5. Build Image for Running Discourse Benchmarks with Compiled Rubies

```bash
sudo docker build -t tgxworld/ruby_compilers_discourse_bench .
```
### 6. Run Discourse Benchmarks and Copy Results

```bash
sudo docker run --name discourse_redis -d redis:2.8.19 && sudo docker run --name discourse_postgres -d postgres:9.3.5
sudo docker run --link discourse_postgres:postgres --link discourse_redis:redis tgxworld/ruby_compilers_discourse_bench
sudo docker cp <Container ID>:/compilers_discourse_results compilers_discourse_results
```

### 7. Generate CSV for Discourse Benchmarks
```bash
cd compilers_discourse_results
ruby compile_results.rb
```
