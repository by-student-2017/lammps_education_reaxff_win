# lammps_education_reaxff_win

Lammps ZTC for education (windows 10 (64 bit))
------------------------------------------------------------------------------
�� lammps

�� �C���X�g�[�����@
1. http://packages.lammps.org/windows.html ��HP��"64-bit Windows download area"���N���b�N����
2. LAMMPS-64bit-18Jun2019.exe ���_�E�����[�h���ĉ𓀂���
3. �f�B�t�H���g�̐ݒ�̂܂܍Ō�܂Ői�߂΂悢
�ȏ�� lammps �̃_�E�����[�h�Ɛݒ�͊����ł�

�� �`��\�t�g�ignuplot��Ovito�j
  gnuplot��Ovito�ɂ��Ă�web��ɗL�v�ȏ�񂪖L�x�ɂ���܂��̂ŁA���萔�����������܂����A����������Q�Ƃ�������
  

------------------------------------------------------------------------------
�� ReaxFF �|�e���V������p�������q���͊w�V�~�����[�V����

�� ���̓t�@�C���̃_�E�����[�h
    by-student-2017 �� lammps_education_reaxff_win (https://github.com/by-student-2017/lammps_education_reaxff_win) ������̓t�@�C�����_�E�����[�h���ĉ𓀂���B�E����[Clone or download]���N���b�N���Ă��������ƁADownload ZIP ���\������܂�
  
�� �V�~�����[�V�����̎��s
1. �e��̃t�H���_�̒��ɂ���run.bat���_�u���N���b�N����Όv�Z������
2. cfg��Ovito�ŊJ���΍\����������
3. plot�ƋL�ڂ̂���t�@�C�����_�u���N���b�N����ΐ}��������
  �I������ꍇ�͍�����ʂ�Enter������
  �� ���x���ړI�̒l�ɂȂ��Ă��邩�A�G�l���M�[�����̒l�ɂȂ��Ă��邩���m�F���Ă݂Ă�������
�� �ȏ�̎菇�́Adata.ch�ɂ��錴�q�̏�������������Α��̒Y�����f�iC-H�j�ł����l�Ɍv�Z���\�ł��iAvogadro�Ȃǂ̃t���[�\�t�g��p���č\���̃t�@�C���idata.ch�j�������������܂��j
�� plot���瓾����G(r)��X���⒆���q���̎������ʂƂ̔�r�ɗ��p������̂ł��Bmsd�͎��Ȋg�U�W�������߂�̂ɗ��p������̂ł�

������reaxFF�̃|�e���V������p���Ă��邽�߁Aairebo�|�e���V�����̌v�Z���Ԃ����v�Z���Ԃ�����������܂��B

�� tutorial_1_ch
  CH�p�̓��̓t�@�C���̗�ł��Bdata.ch ������������Ƒ��̒Y�����f�iC, H����Ȃ镨���j�ł��v�Z���\�ł��B

�� tutorial_1_cho
  CHO�p�̓��̓t�@�C���̗�ł��Bdata.cho ������������Ƒ��̒Y�������iC, H, O����Ȃ镨���j�ł��v�Z���\�ł��B

�� tutorial_1_chon_rdx
  CHON�p�̓��̓t�@�C���̗�ł��Bdata.chon ������������Ƒ���C, H, O, N����Ȃ镨���ł��v�Z���\�ł��B
  rdx(�g�����`�����g���j�g���A�~��)�p�̌v�Z��Ƃ���lammps��Examples�ɒu����Ă��܂��itatb=�g���A�~�m�g���j�g���x���[���Ȃǂ̗�������ꏊ�ɒu����Ă��܂��j�B

�� tutorial_4_ch_thermal
  �M�`�����v�Z�iC-H�p�j

�� tutorial_4_cho_thermal
  �M�`�����v�Z�iC-H-O�p�j

�� tutorial_4_chon_thermal
  �M�`�����v�Z�iC-H-O-N�p�j

�� �\�����f�ɂ�镪�ނ́ihttp://www.book-stack.com/browsing/9784785377175t.pdf�j���Q�Ƃ���Ƃ悢�ł��B
�� ���W�ł�CH�p�̂��̂�ZBL�␳�i���q�Ԃ̍��G�l���M�[�Փ˂̂��߂̕␳�j�̂��߂���̗��CHO, CHON�̗�Ƃ͖��m�ɈقȂ������ʂ������܂��iH���ړ����₷�����ʂɂȂ��Ă���B���̂��߁ANEV�̐ݒ�ŔM�`�������v�Z�������A���ꂾ���M�`�������ꌅ����񌅒��x�傫���l�ɂȂ��Ă���j�BRDF����d�ɏo�͂���Ă���iCHON�����l�j�B
�� CHO�p�̃t�@�C����param.qeq��CHO�̏��ɏ��������Ă��܂��B

------------------------------------------------------------------------------
�� �ԊO�X�y�N�g��
  �������python���C���X�g�[���ł���������ł��B

�� IR spectra [IR1]
1. git clone https://github.com/EfremBraun/calc-ir-spectra-from-lammps.git
2. cd calc-ir-spectra-from-lammps
3. "C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.infrared
4. python calc-ir-spectra.py
  IR-zoom-spectra.png���J���ƃX�y�N�g���������܂��B in.infrared�ł̍Ō�� run �̐��l��傫������Ƃ��悢�X�y�N�g���������܂��Bin.infrared�̒��ɏ�����Ă���R�����g��ǂނƗǂ��ł��B�������A12���ԂȂǂƂ��������̎��Ԃ��K�v�ɂȂ�܂��BO K��IR�ŗǂ���Όv�Z�����ɂ����܂���MOPAC��p���������Y��ȃX�y�N�g�������Z�����ԂŌv�Z�ł��܂��B

�� tutorial_6_cho_IR
  �ԊO�X�y�N�g���̌v�Z�iC-H-O�p�j
  ��̗�i"IR spectra"�j�����������玟�̂悤�ɂ���ƐԊO�X�y�N�g�����v�Z�ł��܂��B
1. run.bat ���_�u���N���b�N
2. python calc-ir-spectra.py

�� tutorial_6_chon_IR
  �ԊO�X�y�N�g���̌v�Z�iC-H-O-N�p�j
  ��̗�i"IR spectra"�j�����������玟�̂悤�ɂ���ƐԊO�X�y�N�g�����v�Z�ł��܂��B
1. run.bat ���_�u���N���b�N
2. python calc-ir-spectra.py

�� �����̌v�Z�͔��ɒ������Ԃ��K�v�ɂȂ�܂��BStep 1.�𑖂点�ċA��C�����ł�������ǂ��ł��傤�B�X�y�N�g�������V���[�v�ɂ�������΁A�Ō��run�̒l�����傫�Ȓl�ɂ��܂��B

------------------------------------------------------------------------------
�� References

[IR1] [lammps-users] Script for calculating IR spectra
  https://lammps.sandia.gov/threads/msg64502.html
  calc-ir-spectra-from-lammps
  https://github.com/EfremBraun/calc-ir-spectra-from-lammps

------------------------------------------------------------------------------
