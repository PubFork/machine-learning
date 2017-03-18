# 基本概念

## 概述
>训练集，测试集，特征向量，监督学习，非监督学习，半监督学习，分类，回归

- 训练集: 用来进行训练，也就是产生模型或者算法的数据集
- 测试集：用来专门进行测试已经学习好的模型或者算法的数据集
- 特征向量：属性的集合，通常用一个向量来表示，附属于一个实例
- 分类 (classification): 目标标记为类别型数据，例如是否享受运动
- 回归(regression): 目标标记为连续性数值，例如房价问题
- 例子
	```
	研究肿瘤良性，恶性于尺寸，颜色的关系
  特征值：肿瘤尺寸，颜色
  标记：良性/恶性
	```
	1. 有监督学习(supervised learning)： 训练集有类别标记
	2. 无监督学习(unsupervised learning)： 无类别标记
	3. 半监督学习（semi-supervised learning)：有类别标记的训练集 + 无标记的训练集