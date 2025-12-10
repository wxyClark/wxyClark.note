# 基础配置
JEKYLL_VERSION := 4.3.2
SITE_DIR := _site
GITHUB_REPO := https://github.com/wxyClark/wxyClark.github.io.git
BRANCH := gh-pages

# 安装依赖（首次运行或 Gemfile 更新时使用）
install:
	bundle install --path vendor/bundle

# 本地预览（带自动刷新）
serve:
	bundle exec jekyll serve --livereload --port 4000

# 构建静态文件（生成到 _site 目录）
build:
	bundle exec jekyll build --future --unpublished

# 清理构建产物
clean:
	rm -rf $(SITE_DIR)
	bundle exec jekyll clean

# 部署到 GitHub Pages（需提前配置 Git 仓库）
deploy: build
	cd $(SITE_DIR) && \
	git init && \
	git add . && \
	git commit -m "Deploy $(shell date +'%Y-%m-%d %H:%M')" && \
	git push -f $(GITHUB_REPO) master:$(BRANCH) && \
	cd .. && \
	rm -rf $(SITE_DIR)/.git

# 帮助信息
help:
	@echo "可用命令:"
	@echo "  make install   - 安装依赖（首次运行）"
	@echo "  make serve     - 本地预览（访问 http://localhost:4000）"
	@echo "  make build     - 构建静态文件到 _site 目录"
	@echo "  make clean     - 清理构建产物"
	@echo "  make deploy    - 构建并部署到 GitHub Pages"