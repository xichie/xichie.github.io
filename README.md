# 个人学术主页

这是基于 [tangjyan/zh-cn](https://github.com/tangjyan/zh-cn) 整理的中文个人学术主页模板，适合部署到 GitHub Pages。

## 需要修改的文件

- `_config.yml`: 站点标题、仓库名、邮箱、GitHub、ORCID、Google Scholar 等个人信息。
- `_pages/about.md`: 首页正文，包括简介、学历、论文成果、项目、奖项、会议和工作经历。
- `images/avatar.svg`: 头像占位图，可以替换为自己的照片或头像。
- `_data/navigation.yml`: 顶部导航。

## Google Scholar 引用统计

如果要启用自动引用统计：

1. 打开你的 Google Scholar 主页，找到 URL 里的 `user=` 参数。
2. 在 GitHub 仓库中进入 `Settings -> Secrets and variables -> Actions -> New repository secret`。
3. 新增 secret：
   - Name: `GOOGLE_SCHOLAR_ID`
   - Value: 你的 Scholar ID
4. 当前 `_config.yml` 已填写：
   - `repository: "xichie/jiaxingqi.github.io"`
   - `author.googlescholar: "https://scholar.google.com/citations?user=-sLEDGMAAAAJ&hl=zh-CN"`

GitHub Actions 中需要新增的 Scholar secret 为：

```text
GOOGLE_SCHOLAR_ID=-sLEDGMAAAAJ
```

工作流会定时生成 `google-scholar-stats` 分支，页面会从该分支读取引用统计。

## 本地预览

```bash
bundle install
bundle exec jekyll serve
```

然后打开 `http://127.0.0.1:4000`。

如果你在 macOS 系统 Ruby 或中文路径下遇到 Bundler / Nokogiri 安装问题，可以使用临时依赖目录并让 Nokogiri 使用系统库：

```bash
BUNDLE_PATH=/private/tmp/acad-homepage-bundle BUNDLE_BUILD__NOKOGIRI=--use-system-libraries bundle install
BUNDLE_PATH=/private/tmp/acad-homepage-bundle BUNDLE_BUILD__NOKOGIRI=--use-system-libraries bundle exec jekyll serve
```

## 部署到 GitHub Pages

当前配置按以下仓库信息填写：

```text
xichie/jiaxingqi.github.io
```

如果你希望最终访问地址就是：

```text
https://jiaxingqi.github.io
```

GitHub 账号或组织名需要是 `jiaxingqi`，仓库名需要是 `jiaxingqi.github.io`。如果继续使用 GitHub 用户名 `xichie`，默认的 GitHub Pages 用户主页地址通常会是 `https://xichie.github.io`，而 `xichie/jiaxingqi.github.io` 更像项目仓库名。
