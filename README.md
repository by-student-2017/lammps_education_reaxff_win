# lammps_education_reaxff_win

Lammps ZTC for education (windows 10 (64 bit))
------------------------------------------------------------------------------
■ lammps

□ インストール方法
1. http://packages.lammps.org/windows.html のHPで"64-bit Windows download area"をクリックする
2. LAMMPS-64bit-18Jun2019.exe をダウンロードして解凍する
3. ディフォルトの設定のまま最後まで進めばよい
以上で lammps のダウンロードと設定は完了です

□ 描画ソフト（gnuplotとOvito）
  gnuplotとOvitoについてはweb上に有益な情報が豊富にありますので、お手数をおかけしますが、そちらをご参照ください
  

------------------------------------------------------------------------------
■ ReaxFF ポテンシャルを用いた分子動力学シミュレーション

□ 入力ファイルのダウンロード
    by-student-2017 の lammps_education_reaxff_win (https://github.com/by-student-2017/lammps_education_reaxff_win) から入力ファイルをダウンロードして解凍する。右側の[Clone or download]をクリックしていただくと、Download ZIP が表示されます
  
□ シミュレーションの実行
1. 各種のフォルダの中にあるrun.batをダブルクリックすれば計算が走る
2. cfgをOvitoで開けば構造が得られる
3. plotと記載のあるファイルをダブルクリックすれば図が得られる
  終了する場合は黒い画面でEnterを押す
  ※ 温度が目的の値になっているか、エネルギーが一定の値になっているかを確認してみてください
※ 以上の手順は、data.chにある原子の情報を書きかえれば他の炭化水素（C-H）でも同様に計算が可能です（Avogadroなどのフリーソフトを用いて構造のファイル（data.ch）を作られる方もいます）
※ plotから得られるG(r)はX線や中性子線の実験結果との比較に利用するものです。msdは自己拡散係数を求めるのに利用するものです

これらはreaxFFのポテンシャルを用いているため、aireboポテンシャルの計算時間よりも計算時間が多くかかります。

□ tutorial_1_ch
  CH用の入力ファイルの例です。data.ch を書き換えると他の炭化水素（C, Hからなる物質）でも計算が可能です。

□ tutorial_1_cho
  CHO用の入力ファイルの例です。data.cho を書き換えると他の炭水化物（C, H, Oからなる物質）でも計算が可能です。

□ tutorial_1_chon_rdx
  CHON用の入力ファイルの例です。data.chon を書き換えると他のC, H, O, Nからなる物質でも計算が可能です。
  rdx(トリメチレントリニトロアミン)用の計算例としてlammpsのExamplesに置かれています（tatb=トリアミノトリニトロベンゼンなどの例も同じ場所に置かれています）。

□ tutorial_4_ch_thermal
  熱伝導率計算（C-H用）

□ tutorial_4_cho_thermal
  熱伝導率計算（C-H-O用）

□ tutorial_4_chon_thermal
  熱伝導率計算（C-H-O-N用）

※ 構成元素による分類は（http://www.book-stack.com/browsing/9784785377175t.pdf）を参照するとよいです。
※ 発展でのCH用のものはZBL補正（原子間の高エネルギー衝突のための補正）のためか上の例やCHO, CHONの例とは明確に異なった結果を示します（Hが移動しやすい結果になっている。そのため、NEVの設定で熱伝導率を計算したが、これだけ熱伝導率が一桁から二桁程度大きい値になっている）。RDFも二重に出力されている（CHONも同様）。
※ CHO用のファイルのparam.qeqはCHOの順に書き換えています。

------------------------------------------------------------------------------
■ 赤外スペクトル
  こちらはpythonをインストールできる方向けです。

□ IR spectra [IR1]
1. git clone https://github.com/EfremBraun/calc-ir-spectra-from-lammps.git
2. cd calc-ir-spectra-from-lammps
3. "C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.infrared
4. python calc-ir-spectra.py
  IR-zoom-spectra.pngを開くとスペクトルが得られます。 in.infraredでの最後の run の数値を大きくするとよりよいスペクトルが得られます。in.infraredの中に書かれているコメントを読むと良いです。ただし、12時間などという多くの時間が必要になります。O KのIRで良ければ計算条件にもよりますがMOPACを用いた方が綺麗なスペクトルをより短い時間で計算できます。

□ tutorial_6_cho_IR
  赤外スペクトルの計算（C-H-O用）
  上の例（"IR spectra"）が成功したら次のようにすると赤外スペクトルが計算できます。
1. run.bat をダブルクリック
2. python calc-ir-spectra.py

□ tutorial_6_chon_IR
  赤外スペクトルの計算（C-H-O-N用）
  上の例（"IR spectra"）が成功したら次のようにすると赤外スペクトルが計算できます。
1. run.bat をダブルクリック
2. python calc-ir-spectra.py

※ これらの計算は非常に長い時間が必要になります。Step 1.を走らせて帰る気持ちでいる方が良いでしょう。スペクトルをよりシャープにしたければ、最後のrunの値をより大きな値にします。

------------------------------------------------------------------------------
■ References

[IR1] [lammps-users] Script for calculating IR spectra
  https://lammps.sandia.gov/threads/msg64502.html
  calc-ir-spectra-from-lammps
  https://github.com/EfremBraun/calc-ir-spectra-from-lammps

------------------------------------------------------------------------------
