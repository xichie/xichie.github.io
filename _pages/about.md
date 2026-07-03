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

### Selected Publications <small><a href="{{ scholar_url }}">View all</a></small>

<sup>†</sup> Corresponding author.

#### 2026

- Yizhen Li, Shaohan Huang, `Jiaxing Qi`, Yao Lu, Lei Quan, Dongran Han, Bin Li, Xincan Liu, Zhongzhi Luan<sup>†</sup>. Evaluating Large-Scale and Lightweight Large Language Models for Traditional Chinese Medicine Exam Questions: A Comparative Study. *Journal of Evidence-Based Medicine*, 19(1): e70118, 2026.<br>
[[Webpage]](https://onlinelibrary.wiley.com/doi/abs/10.1111/jebm.70118) <span class='show_paper_citations' data='-sLEDGMAAAAJ:qxL8FJ1GzNcC'></span>

- Yifan Xu, Chao Zhang, Ruifei Ma, Fei Gao, Zhifei Yang, `Jiaxing Qi`, Zhipeng Chen. MotionEnhancer: Leveraging Video Diffusion for Motion-Enhanced Vision-Language Models. *Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR)*, pp. 2778-2787, 2026.<br>
[[Webpage]](https://openaccess.thecvf.com/content/CVPR2026/html/Xu_MotionEnhancer_Leveraging_Video_Diffusion_for_Motion-Enhanced_Vision-Language_Models_CVPR_2026_paper.html) <span class='show_paper_citations' data='-sLEDGMAAAAJ:9ZlFYXVOiuMC'></span>

#### 2025

- `Jiaxing Qi`, Zhongzhi Luan<sup>†</sup>, Shaohan Huang, Carol Fung, Yuchen Wang, Aibin Wang, Hongyu Zhang, Hailong Yang, Depei Qian. LogMoE: Lightweight Expert Mixture for Cross-System Log Anomaly Detection. *2025 40th IEEE/ACM International Conference on Automated Software Engineering (ASE)*, pp. 330-341, 2025. 🏆 Distinguished Paper Award.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11334514/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:M3ejUd6NZC8C'></span>

- `Jiaxing Qi`, Zhongzhi Luan<sup>†</sup>, Shaohan Huang, Yao Lu, Hailong Yang, Depei Qian. LogReader: General-Purpose Log Analysis via Open-Source Large Language Models. *2025 International Joint Conference on Neural Networks (IJCNN)*, pp. 1-8, 2025.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11227375/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:4TOpqqG69KYC'></span>

- `Jiaxing Qi`, Yifan Xu, Zhifei Yang, Ruifei Ma, Chao Zhang, Kuifei Yu. BridgeGLM: Bridging Graph and Language Spaces for Domain Generalization. *Proceedings of the 33rd ACM International Conference on Multimedia (ACM MM)*, pp. 1258-1267, 2025.<br>
[[Webpage]](https://dl.acm.org/doi/abs/10.1145/3746027.3755086) <span class='show_paper_citations' data='-sLEDGMAAAAJ:Zph67rFs4hoC'></span>

- Zhifei Yang, Keyang Lu, Chao Zhang, `Jiaxing Qi`, Hanqi Jiang, Ruifei Ma, Shenglin Yin, Yifan Xu, Mingzhe Xing, Zhen Xiao, Jieyi Long, Xiangde Liu, Guangyao Zhai. MMGDreamer: Mixed-Modality Graph for Geometry-Controllable 3D Indoor Scene Generation. *Proceedings of the AAAI Conference on Artificial Intelligence*, 39(9): 9391-9399, 2025.<br>
[[Webpage]](https://ojs.aaai.org/index.php/AAAI/article/view/33017) <span class='show_paper_citations' data='-sLEDGMAAAAJ:hqOjcs7Dif8C'></span>

- Xiaoyan Wang, Zeju Li, Yifan Xu, `Jiaxing Qi`, Zhifei Yang, Ruifei Ma, Xiangde Liu, Chao Zhang. Spatial 3D-LLM: Exploring Spatial Awareness in 3D Vision-Language Models. *2025 IEEE International Conference on Multimedia and Expo (ICME)*, pp. 1-6, 2025.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11208990/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:KlAtU1dfN6UC'></span>

- Ruifei Ma, Yifan Xu, Yuze Li, Yanping Fang, Zhifei Yang, `Jiaxing Qi`, Xinyu Zhao, Chao Zhang. CTSG: Integrating Context and Way Topology Into Scene Graph for Zero-Shot Navigation. *2025 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)*, pp. 18934-18941, 2025.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11246966/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:YOwf2qJgpHMC'></span>

- Shaohan Huang, Yi Liu, `Jiaxing Qi`, Hailong Yang, Zhongzhi Luan<sup>†</sup>, Depei Qian. Learning to Follow Domain-Specific Instruction with Verifiable Rewards. *2025 International Joint Conference on Neural Networks (IJCNN)*, pp. 1-8, 2025.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/11228901/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:_kc_bZDykSQC'></span>

- Yao Lu, Zhongzhi Luan<sup>†</sup>, Gen Li, `Jiaxing Qi`, Bin Han, Hailong Yang, Depei Qian. 面向迈创 3000 异构处理器的多头注意力机制多重并行优化. *Jisuanji Xuebao/Chinese Journal of Computers*, 48(9): 2049-2063, 2025.<br>
[[Webpage]](https://research.buaa.edu.cn/zh/publications/%E9%9D%A2%E5%90%91%E8%BF%88%E5%88%9B3000%E5%BC%82%E6%9E%84%E5%A4%84%E7%90%86%E5%99%A8%E7%9A%84%E5%A4%9A%E5%A4%B4%E6%B3%A8%E6%84%8F%E5%8A%9B%E6%9C%BA%E5%88%B6%E5%A4%9A%E9%87%8D%E5%B9%B6%E8%A1%8C%E4%BC%98%E5%8C%96/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:aqlVkmm33-oC'></span>

#### 2024

- `Jiaxing Qi`, Wencong Xiao, Mingzhen Li, Chaojie Yang, Yong Li, Wei Lin, Hailong Yang, Zhongzhi Luan<sup>†</sup>, Depei Qian. ElasticBatch: A Learning-Augmented Elastic Scheduling System for Batch Inference on MIG. *IEEE Transactions on Parallel and Distributed Systems*, 35(10): 1708-1720, 2024.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10605084/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:ufrVoPGSRksC'></span>

- `Jiaxing Qi`, Zhongzhi Luan<sup>†</sup>, Shaohan Huang, Carol Fung, Hailong Yang. LogSay: An Efficient Comprehension System for Log Numerical Reasoning. *IEEE Transactions on Computers*, 73(7): 1809-1821, 2024.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10494680/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:W7OEmFMy1HYC'></span>

- `Jiaxing Qi`. Log Analysis with Interpretability and Usability. *Service-Oriented Computing - ICSOC 2024 Workshops, Lecture Notes in Computer Science*, pp. 208-213, 2024.<br>
[[Webpage]](https://link.springer.com/chapter/10.1007/978-981-96-7423-7_21) <span class='show_paper_citations' data='-sLEDGMAAAAJ:kNdYIx-mwKoC'></span>

- Shaohan Huang, Yi Liu, `Jiaxing Qi`, Jing Shang, Zhiwen Xiao, Carol Fung, Zhihui Wu, Hailong Yang, Zhongzhi Luan<sup>†</sup>, Depei Qian. GLOSS: Guiding Large Language Models to Answer Questions from System Logs. *2024 IEEE International Conference on Software Analysis, Evolution and Reengineering (SANER)*, pp. 91-101, 2024.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10589781/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:WF5omc3nYNoC'></span>

- Yizhen Li, Zhongzhi Luan<sup>†</sup>, Yixing Liu, Heyuan Liu, `Jiaxing Qi`, Dongran Han. Automated Information Extraction Model Enhancing Traditional Chinese Medicine RCT Evidence Extraction (Evi-BERT): Algorithm Development and Validation. *Frontiers in Artificial Intelligence*, 7: 1454945, 2024.<br>
[[Webpage]](https://www.frontiersin.org/journals/artificial-intelligence/articles/10.3389/frai.2024.1454945/full) <span class='show_paper_citations' data='-sLEDGMAAAAJ:_FxGoFyzp5QC'></span>

#### 2023

- `Jiaxing Qi`, Zhongzhi Luan<sup>†</sup>, Shaohan Huang, Carol Fung, Hailong Yang, Hanlu Li, Danfeng Zhu, Depei Qian. LogEncoder: Log-Based Contrastive Representation Learning for Anomaly Detection. *IEEE Transactions on Network and Service Management*, 20(2): 1378-1391, 2023.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10025803/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:qjMakFHDy7sC'></span>

- `Jiaxing Qi`, Shaohan Huang, Zhongzhi Luan<sup>†</sup>, Shu Yang, Carol Fung, Hailong Yang, Depei Qian, Jing Shang, Zhiwen Xiao, Zhihui Wu. LogGPT: Exploring ChatGPT for Log-Based Anomaly Detection. *2023 IEEE International Conference on High Performance Computing & Communications, Data Science & Systems, Smart City & Dependability in Sensor, Cloud & Big Data Systems & Application (HPCC/DSS/SmartCity/DependSys)*, pp. 273-280, 2023.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10466820/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:zYLM7Y9cAGgC'></span>

- `Jiaxing Qi`, Zhongzhi Luan<sup>†</sup>, Shaohan Huang, Carol Fung, Hailong Yang, Depei Qian. SpikeLog: Log-Based Anomaly Detection via Potential-Assisted Spiking Neuron Network. *IEEE Transactions on Knowledge and Data Engineering*, 36(12): 9322-9335, 2023.<br>
[[Webpage]](https://ieeexplore.ieee.org/abstract/document/10375739/) <span class='show_paper_citations' data='-sLEDGMAAAAJ:Y0pCki6q_DkC'></span>

<!-- <span class='anchor' id='projects'></span>

# Projects

- *YYYY - YYYY*, Project title, your role. Briefly describe the goal, method, and your contribution.
- *YYYY - YYYY*, Project title, your role. Briefly describe the goal, method, and your contribution.

<span class='anchor' id='awards'></span> -->

# Awards

- *April 2025*, 1st WWW 2025 Competition Track SmartMem: Memory Failure Prediction for Reliable Cloud Service.
<!-- - *YYYY.MM*, Award name, granting organization. -->

<!-- <span class='anchor' id='talks'></span>

# Talks

- *YYYY.MM*, Talk or conference title, location, presentation type.
- *YYYY.MM*, Talk or conference title, location, presentation type. -->

<span class='anchor' id='experience'></span>

# Experience
- *April 2026 - Present*, Postdoctoral Researcher, Beihang University, working with Prof. Yongxin Tong.
- *April 2024 - Dec 2025*, Research Intern, Beijing Digital Native Digital City Research Center.
- *Aug 2021 - Sep 2023*, Research Intern, Alibaba Cloud Computing Platform.
