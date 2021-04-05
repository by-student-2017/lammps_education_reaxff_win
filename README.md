# lammps_education_reaxff_win

Lammps ZTC for education (windows 10 (64 bit))
------------------------------------------------------------------------------
■ lammps

□ インストール方法
1. http://packages.lammps.org/windows.html のHPで"their own download area"と”64bit”をクリックする
  (https://rpm.lammps.org/windows/admin/64bit/index.html)
2. LAMMPS-64bit-18Jun2019.exe (https://rpm.lammps.org/windows/admin/64bit/LAMMPS-64bit-18Jun2019.exe) をダウンロードして実行する
3. ディフォルトの設定のまま最後まで進めばよい
以上で lammps のダウンロードと設定は完了です
※ 配布元のHPが変更を加えるなどして、別のバージョンのlammpsを使う必要になった場合には、run.batで["C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.lmp]の部分をインストールしたlammpsのバージョンに対応するものに書き換えてください。または[C:\Program Files\LAMMPS 64-bit **********]を書き換えるという方法もあります

□ 描画ソフト（gnuplotとOvito）
* gnuplot（http://www.gnuplot.info/）
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito（https://www.ovito.org/windows-downloads/）
※ web上に情報がありますので、お手数をおかけしますが、そちらをご参照ください
※ gnuplotのインストールと環境設定 (Edit: Dec/11/2020)
1. gnuplot - Browse /gnuplot at SourceForge.net から gp528-win64-mingw.exe を得る
  gp528-win64-mingw.exe をダブルクリック。設定はディフォルトのままでよい
2. コントロール パネル > システムとセキュリティ > システム
3. システムの環境設定 > 環境変数（N）... > システム環境変数（S）のPath > 編集（I）... > 新規（N）> C:\Program Files\gnuplot\bin を追加する > OK > OK
------------------------------------------------------------------------------
■ ReaxFF ポテンシャルを用いた分子動力学シミュレーション

□ 入力ファイルのダウンロード
    by-student-2017 の lammps_education_reaxff_win (https://github.com/by-student-2017/lammps_education_reaxff_win) から入力ファイルをダウンロードして解凍する。右側の[Clone or download]をクリックしていただくと、Download ZIP が表示されます
  
□ シミュレーションの実行
1. 各種のフォルダの中にあるrun.batをダブルクリックすれば計算が走る
2. cfgをOvitoで開けば構造が得られる
3. plotと記載のあるファイルをダブルクリックすれば図が得られる
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

□ pythonのインストール
1. python(https://www.python.org/downloads)から Release version と書かれたところから下にある Python 3.8.1 をクリックします。Windows x86-64 executable installer をクリックして保存します。
2. ダウンロードした python-3.8.1-amd64.exe をダブルクリックします。
3. Add Python 3.8 to PATH にもチェックを入れます。
4. Install Now をクリックします。
5. shift を押しながら右クリックして PowerShellウインドウを開きます。そして、下記をコピー&ペーストします。
  python -m pip install numpy
  python -m pip install scipy
  python -m pip install matplotlib
  python -m pip install pandas
  python -m pip install scikit-learn
  python -m pip install opencv-contrib-python
上から3つまで必要ですが、今後、機械学習などを使うことになるでしょうから、この時点でインストールしておきます。

□ IR spectra [IR1]
1. git clone https://github.com/EfremBraun/calc-ir-spectra-from-lammps.git
2. cd calc-ir-spectra-from-lammps
3. "C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.infrared
4. python calc-ir-spectra.py
  IR-zoom-spectra.pngを開くとスペクトルが得られます。 in.infraredでの最後の run の数値を大きくするとよりよいスペクトルが得られます。in.infraredの中に書かれているコメントを読むと良いです。ただし、12時間などという多くの時間が必要になります。O KのIRで良ければ計算条件にもよりますがMOPACを用いた方が綺麗なスペクトルをより短い時間で計算できます。

□ tutorial_6_ch_IR
  赤外スペクトルの計算（C-H-O用のものでdata.choの酸素を除いて使っています。C-H-O-N用でも同様に計算が可能だと思われます
  上の例（"IR spectra"）が成功したら次のようにすると赤外スペクトルが計算できます。
1. run.bat をダブルクリック
2. plot_IR.gpl をダブルクリック
3. plot_IR_4000.gpl をダブルクリック

□ tutorial_6_cho_IR
  赤外スペクトルの計算（C-H-O用）
  上の例（"IR spectra"）が成功したら次のようにすると赤外スペクトルが計算できます。
1. run.bat をダブルクリック
2. plot_IR.gpl をダブルクリック
3. plot_IR_4000.gpl をダブルクリック

□ tutorial_6_chon_IR
  赤外スペクトルの計算（C-H-O-N用）
  上の例（"IR spectra"）が成功したら次のようにすると赤外スペクトルが計算できます。
1. run.bat をダブルクリック
2. plot_IR.gpl をダブルクリック
3. plot_IR_4000.gpl をダブルクリック

※ これらの計算は非常に長い時間が必要になります。Step 1.を走らせて帰る気持ちでいる方が良いでしょう。スペクトルをよりシャープにしたければ、最後のrunの値をより大きな値にします。
※ IR-と付いたファイルがあると上手く動作しないことがあります。その場合は、IR-と付いたファイルを削除してください。Linux OSのUbuntuでそれが発生しました。
※ [IR-zoom-spectra-quantumcorrection.png] をダブルクリックして図を表示しても良いですし、IR-data.txt（の1列目と最後の列）を使ってExcelなどで図を描くこともできます。
※ 横軸はスケーリングファクターを掛けて実験値により近づけるのも良いかと思います。

------------------------------------------------------------------------------
■ References


[IR1] [lammps-users] Script for calculating IR spectra
  https://lammps.sandia.gov/threads/msg64502.html
  calc-ir-spectra-from-lammps
  https://github.com/EfremBraun/calc-ir-spectra-from-lammps


[P1] http://kiff.vfab.org/
  http://kiff.vfab.org/reax
  potentials folder are getting from above URL.
------------------------------------------------------------------------------
