# knn-excersices
最近傍識別器の演習

# 準備

* 1. Matlab か Octave をインストールする．
* 2. Download
<a href="https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/200127/stu-hikkoshiset.2001271132.tgz" rel="nofollow">stu-hikkoshiset.2001271132.tgz</a>
and find a folder names &quot;mfiles&quot;.
Many matlab functions are under the folder &quot;mfiles&quot;.
Put the functions somewhere and add the directories
to the path variable for Matlab or Octave.

# 最近傍識別器の課題

Download <a href="https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/200223/hayuci13a.zip" rel="nofollow">hayuci13a.zip</a>. This file contains five data files: yXT_car.csv, yXT_seeds.csv, yXT_wine.csv, yXT_winequality-white.csv, yXT_yeast.csv. Each line corresponds to one example. The format is
<pre> Class, Feature1, Feature2,... , Feature n</pre>
Do the followings:

* 1. データセット wine に対して，
最初の行の例題を評価用，
残りの行の例題を訓練用として，
最近傍識別を行え．
ただし，k-最近傍識別器 の近傍数は k=1 とせよ．

* 2. 各データセットに対して，
最初の行の例題を評価用，
残りの行の例題を訓練用として，
最近傍識別を行え．
ただし，k-最近傍識別器 の近傍数は k=1 とせよ．

* 3. データセット wine に対して，
各クラスのデータを訓練用と評価用を 7:3 にランダムに分けよ．

* 4. データセット wine に対して，
k-最近傍識別器 の k=1 とし，評価用データの識別率を出せ．

* 5. 3. を１０回繰り返して，識別率の平均値と標準偏差を算出せよ．

* 6. 各データセットに対して，各クラスのデータを訓練用と評価用を
7:3 にランダムに分け，k-最近傍識別器 の k=1 とし，
評価用データの識別率を出せ．

* 7. 各データセットに対して，6. を１０回繰り返して，識別率の平均値と標準偏差を算出せよ．

* 8. k-最近傍識別器 の k=1,2,3,4,5 を試せ．
ただし，重みつきの voting をせよ．
重みは exp( - (ユークリッド距離)^2/(2σ^2)) で求めよ．
ただし，σは訓練用データの距離値の中間値とする．
これは，距離行列 D をまず計算し，$median(D(:))$ から求める．
    * Translation into English:
Test k-NN classifiers with k=1,2,3,4,5.
Therein, the weighted voting should be used.
The weight is defined as
<pre>  exp(-(d^2/2\sigma^2) )</pre>
where d is the Euclidean distance and
\sigma is the median of training data.
In particular, $\sigma := median(D(:))$
where $D$ is the distance matrix.
* 余裕があったら，C言語風にコーディングする場合と
行列計算でコーディングする場合とで計算時間を比較して
みてください．
    * Translation into English:
Compare the computational time of two implementations.
The one is that the code does not use matrix computation
but use for-loop like C language.
The other uses matrix computation.

