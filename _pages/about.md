---
permalink: /
title: ""
excerpt: ""
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

{% assign scholar_url = site.author.googlescholar %}
{% if site.google_scholar_stats_use_cdn %}
{% assign gsDataBaseUrl = "https://cdn.jsdelivr.net/gh/" | append: site.repository | append: "@" %}
{% else %}
{% assign gsDataBaseUrl = "https://raw.githubusercontent.com/" | append: site.repository | append: "/" %}
{% endif %}
{% assign url = gsDataBaseUrl | append: "google-scholar-stats/gs_data_shieldsio.json" %}

<span class='anchor' id='about-me'></span>

# About Me

I am a **postdoctoral researcher at Beihang University**, working with **Prof. Yongxin Tong**. I received my Ph.D. degree from **Beihang University** in **2026**, advised by **Prof. Zhongzhi Luan**.


My research interests span artificial intelligence for software engineering, AI-assisted biological data analysis, and AI-enabled system management. I am particularly interested in building practical AI methods that can support automated software engineering workflows, help biologists analyze proteomics data more efficiently, and improve the reliability and observability of modern computing systems.

My research interests include, but are not limited to:

- **AI4SE**: AI-enabled recommender systems for automated software engineering, including log analysis, large language models for software engineering, and related automated SE tasks.
- **AI4Bio**: AI methods that help biologists analyze proteomics data more efficiently, including nanopore protein sequencing, de novo sequencing, and related workflows.
- **AI4Sys**: Effective integration of AI into system management, monitoring, and operations.

<!-- <span class='anchor' id='education'></span> -->

<!-- # Education

- *2026*, Ph.D., Beihang University, advised by Prof. Zhongzhi Luan. -->

<!-- <span class='anchor' id='publications'></span> -->

# Publications
{% if scholar_url %}
Google Scholar citation statistics:
<a href='{{ scholar_url }}'><img src="https://img.shields.io/endpoint?url={{ url | url_encode }}&logo=Google%20Scholar&labelColor=f6f6f6&color=9cf&style=flat&label=Citations"></a>
{% endif %}

### Selected Publications

#### 2025

- `Jiaxing Qi`, Chang Zeng, Zhongzhi Luan, Shaohan Huang, Shu Yang, Yao Lu, Hailong Yang, Depei Qian. Beyond Window-Based Detection: A Graph-Centric Framework for Discrete Log Anomaly Detection. 2025.  
[[Webpage]](https://arxiv.org/abs/2501.12166) <span class='show_paper_citations' data='-sLEDGMAAAAJ:UebtZRa9Y70C'></span>

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Yao Lu, Hailong Yang, Depei Qian. LogReader: General-Purpose Log Analysis via Open-Source Large Language Models. 2025.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11227375/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:4TOpqqG69KYC'></span>

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Carol Fung, Yuchen Wang, Aibin Wang, Hongyu Zhang, Hailong Yang, Depei Qian. LogMoE: Lightweight Expert Mixture for Cross-System Log Anomaly Detection. 2025. 🏆 Distinguished Paper Award.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11334514/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:M3ejUd6NZC8C'></span>

- `Jiaxing Qi`, Yifan Xu, Zhifei Yang, Ruifei Ma, Chao Zhang, Kuifei Yu. BridgeGLM: Bridging Graph and Language Spaces for Domain Generalization. 2025.  
[[Webpage]](https://dl.acm.org/doi/abs/10.1145/3746027.3755086) <span class='show_paper_citations' data='-sLEDGMAAAAJ:Zph67rFs4hoC'></span>

#### 2024

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Carol Fung, Hailong Yang, Depei Qian. FDLoRA: Personalized Federated Learning of Large Language Model via Dual LoRA Tuning. 2024.  
[[Webpage]](https://arxiv.org/abs/2406.07925) <span class='show_paper_citations' data='-sLEDGMAAAAJ:YsMSGLbcyi4C'></span>

- `Jiaxing Qi`, Wencong Xiao, Mingzhen Li, Chaojie Yang, Yong Li, Wei Lin, Hailong Yang, Zhongzhi Luan, Depei Qian. ElasticBatch: A Learning-Augmented Elastic Scheduling System for Batch Inference on MIG. 2024.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10605084/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:ufrVoPGSRksC'></span>

- `Jiaxing Qi`, Chang Zeng, Zhongzhi Luan, Shaohan Huang, Shu Yang, Yao Lu, Bin Han, Hailong Yang, Depei Qian. Quantum Machine Learning in Log-Based Anomaly Detection: Challenges and Opportunities. 2024.  
[[Webpage]](https://arxiv.org/abs/2412.13529) <span class='show_paper_citations' data='-sLEDGMAAAAJ:roLk4NBRz8UC'></span>

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Carol Fung, Hailong Yang. LogSay: An Efficient Comprehension System for Log Numerical Reasoning. 2024.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10494680/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:W7OEmFMy1HYC'></span>

- `Jiaxing Qi`. Log Analysis with Interpretability and Usability. 2024.  
[[Webpage]](https://link.springer.com/chapter/10.1007/978-981-96-7423-7_21) <span class='show_paper_citations' data='-sLEDGMAAAAJ:kNdYIx-mwKoC'></span>

#### 2023

- `Jiaxing Qi`, Shaohan Huang, Zhongzhi Luan, Shu Yang, Carol Fung, Hailong Yang, Depei Qian, Jing Shang, Zhiwen Xiao, Zhihui Wu. LogGPT: Exploring ChatGPT for Log-Based Anomaly Detection. 2023.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10466820/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:zYLM7Y9cAGgC'></span>

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Carol Fung, Hailong Yang, Hanlu Li, Danfeng Zhu, Depei Qian. LogEncoder: Log-Based Contrastive Representation Learning for Anomaly Detection. 2023.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10025803/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:qjMakFHDy7sC'></span>

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Carol Fung, Hailong Yang, Depei Qian. SpikeLog: Log-Based Anomaly Detection via Potential-Assisted Spiking Neuron Network. 2023.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10375739/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:Y0pCki6q_DkC'></span>

#### 2022

- `Jiaxing Qi`, Zhongzhi Luan, Shaohan Huang, Yukun Wang, Carol Fung, Hailong Yang, Depei Qian. AdaAnomaly: Adaptive Anomaly Detection for System Logs with Adversarial Learning. 2022.  
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/9789917/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:UeHWp8X0CEIC'></span>

<!-- <span class='anchor' id='projects'></span>

# Projects

- *YYYY - YYYY*, Project title, your role. Briefly describe the goal, method, and your contribution.
- *YYYY - YYYY*, Project title, your role. Briefly describe the goal, method, and your contribution.

<span class='anchor' id='awards'></span> -->

<!-- # Awards

- *YYYY.MM*, Award name, granting organization.
- *YYYY.MM*, Award name, granting organization. -->

<!-- <span class='anchor' id='talks'></span>

# Talks

- *YYYY.MM*, Talk or conference title, location, presentation type.
- *YYYY.MM*, Talk or conference title, location, presentation type. -->

<span class='anchor' id='experience'></span>

# Experience
- *April 2026 - Present*, Postdoctoral Researcher, Beihang University, working with Prof. Yongxin Tong.
- *April 2024 - Dec 2025*, Research Intern, Beijing Digital Native Digital City Research Center.
- *Aug 2021 - Sep 2023*, Research Intern, Alibaba Cloud Computing Platform.
