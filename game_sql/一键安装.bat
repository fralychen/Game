@echo off
echo *************************************************************************
echo                              ��ҫ��һ����װ
echo     ִ����ҫ�����ݿ�һ����װ�ű����Զ�����"E:\���ݿ�\��ҫƽ̨"Ŀ¼�µ����ݿ⣬
echo �Զ�������ҫ���ʼ���ݿ⡣�밴���������...
echo *************************************************************************
pause
echo.
echo �����������ݿ�
Rem ���ݿ�����
net stop mssqlserver
set Ymd=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2% 
md E:\���ݿ�\��ҫƽ̨����\%ymd%
XCOPY E:\���ݿ�\��ҫƽ̨\* E:\���ݿ�\��ҫƽ̨����\%ymd% /s  /e
if exist E:\���ݿ�\��ҫƽ̨ (echo y|cacls E:\���ݿ�\��ҫƽ̨ /p everyone:f >nul 2>nul &&rd /s /q E:\���ݿ�\��ҫƽ̨) 
md E:\���ݿ�\��ҫƽ̨
net start mssqlserver
set rootPath=1_1�������ݿ�\
osql -E -i "%rootPath%���ݿ�ɾ��.sql"

echo.
echo �������ݿ�
set rootPath=1_1�������ݿ�\
osql -E -i "%rootPath%1_1_�û���ű�.sql"
osql -E -i "%rootPath%1_2_ƽ̨��ű�.sql"
osql -E -i "%rootPath%1_3_��ҿ�ű�.sql"
osql -E -i "%rootPath%1_4_��¼��ű�.sql"
osql -E -i "%rootPath%1_5_���ֿ�ű�.sql"
osql -E -i "%rootPath%1_6_������ű�.sql"
osql -E -i "%rootPath%1_7_��ϰ��ű�.sql"

osql -E -i "%rootPath%2_1_�û���ű�.sql"
osql -E -i "%rootPath%2_2_ƽ̨��ű�.sql"
osql -E -i "%rootPath%2_3_��ҿ�ű�.sql"
osql -E -i "%rootPath%2_4_��¼��ű�.sql"
osql -E -i "%rootPath%2_5_���ֿ�ű�.sql"
osql -E -i "%rootPath%2_6_������ű�.sql"
osql -E -i "%rootPath%2_7_��ϰ��ű�.sql"

echo.
echo �������ӷ�����
set rootPath=1_2�������ӷ�����\
osql -E -i "%rootPath%1_1�û�����.sql"
osql -E -i "%rootPath%1_2ƽ̨����.sql"
osql -E -i "%rootPath%1_3�������.sql"
osql -E -i "%rootPath%1_4��¼����.sql"
osql -E -i "%rootPath%1_5��������.sql"
osql -E -i "%rootPath%1_6��������.sql"
osql -E -i "%rootPath%1_7��ϰ����.sql"

echo.
echo ������ʼ����
set rootPath=1_3������ʼ����\1_1�û���ʼ����\
osql -E -i "%rootPath%ϵͳ����.sql"
osql -E -i "%rootPath%��Ա����.sql"

set rootPath=1_3������ʼ����\1_2ƽ̨��ʼ����\
osql -E -i "%rootPath%���߹�ϵ.sql"
osql -E -i "%rootPath%��������.sql"
osql -E -i "%rootPath%��������.sql"
osql -E -i "%rootPath%�ȼ�����.sql"
osql -E -i "%rootPath%��������.sql"
osql -E -i "%rootPath%ǩ������.sql"
osql -E -i "%rootPath%�ӵ�������.sql"

set rootPath=1_3������ʼ����\1_3��ҳ�ʼ����\
osql -E -i "%rootPath%��������.sql"
osql -E -i "%rootPath%�б�����.sql"

set rootPath=1_3������ʼ����\1_5���ֳ�ʼ����\
osql -E -i "%rootPath%�б�����.sql"

set rootPath=1_3������ʼ����\1_6������ʼ����\
osql -E -i "%rootPath%�б�����.sql"

set rootPath=1_3������ʼ����\1_7��ϰ��ʼ����\
osql -E -i "%rootPath%�б�����.sql"

echo.
echo �����洢����
set rootPath=1_4�����洢����\1_1�û����ݿ�\
osql -E  -i "%rootPath%�󶨻���.sql"
osql -E  -i "%rootPath%��ʶ��¼.sql"
osql -E  -i "%rootPath%�����б�.sql"
osql -E  -i "%rootPath%���Ѳ���.sql"
osql -E  -i "%rootPath%���Ѳ���.sql"
osql -E  -i "%rootPath%���ѵ�¼.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%���ػ���.sql"
osql -E  -i "%rootPath%����Ȩ��.sql"
osql -E  -i "%rootPath%ʵ����֤.sql"
osql -E  -i "%rootPath%У��Ȩ��.sql"
osql -E  -i "%rootPath%У������.sql"
osql -E  -i "%rootPath%�޸�����.sql"
osql -E  -i "%rootPath%�޸�ǩ��.sql"
osql -E  -i "%rootPath%�û�����.sql"
osql -E  -i "%rootPath%�ʺŰ�.sql"
osql -E  -i "%rootPath%�ʺŵ�¼.sql"
osql -E  -i "%rootPath%ע���ʺ�.sql"
osql -E  -i "%rootPath%�Զ�ͷ��.sql"

set rootPath=1_4�����洢����\1_2ƽ̨���ݿ�\
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%���߹���.sql"
osql -E  -i "%rootPath%�ȼ�����.sql"
osql -E  -i "%rootPath%�ͱ�����.sql"
osql -E  -i "%rootPath%�������.sql"
osql -E  -i "%rootPath%��Ա����.sql"
osql -E  -i "%rootPath%���ؽڵ�.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%�������д�.sql"
osql -E  -i "%rootPath%����ҳ��.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%����ʹ��.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%ģ�����.sql"
osql -E  -i "%rootPath%ƽ̨����.sql"
osql -E  -i "%rootPath%ǩ������.sql"
osql -E  -i "%rootPath%�ȼ�����.sql"
osql -E  -i "%rootPath%�������.sql"
osql -E  -i "%rootPath%ʵ������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"

set rootPath=1_4�����洢����\1_3������ݿ�\
osql -E  -i "%rootPath%��ʶ��¼.sql"
osql -E  -i "%rootPath%��ѯ�û�.sql"
osql -E  -i "%rootPath%�һ�����.sql"
osql -E  -i "%rootPath%���ػ���.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%�뿪����.sql"
osql -E  -i "%rootPath%�б�����.sql"
osql -E  -i "%rootPath%����Ȩ��.sql"
osql -E  -i "%rootPath%�ƹ����.sql"
osql -E  -i "%rootPath%д�����.sql"
osql -E  -i "%rootPath%���з���.sql"
osql -E  -i "%rootPath%��Ϸ��¼.sql"
osql -E  -i "%rootPath%��Ϸ����.sql"
osql -E  -i "%rootPath%��Ϸд��.sql"

set rootPath=1_4�����洢����\1_5�������ݿ�\
osql -E  -i "%rootPath%��ʶ��¼.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%�뿪����.sql"
osql -E  -i "%rootPath%�б�����.sql"
osql -E  -i "%rootPath%����Ȩ��.sql"
osql -E  -i "%rootPath%��Ϸ��¼.sql"
osql -E  -i "%rootPath%��Ϸд��.sql"

set rootPath=1_4�����洢����\1_6�������ݿ�\
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%��ʶ��¼.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%��ʼ����.sql"
osql -E  -i "%rootPath%�뿪����.sql"
osql -E  -i "%rootPath%�б�����.sql"
osql -E  -i "%rootPath%����Ȩ��.sql"
osql -E  -i "%rootPath%д�����.sql"
osql -E  -i "%rootPath%д�뽱��.sql"
osql -E  -i "%rootPath%��Ϸ��¼.sql"
osql -E  -i "%rootPath%��Ϸд��.sql"

set rootPath=1_4�����洢����\1_7��ϰ���ݿ�\
osql -E  -i "%rootPath%��ʶ��¼.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%�뿪����.sql"
osql -E  -i "%rootPath%�б�����.sql"
osql -E  -i "%rootPath%����Ȩ��.sql"
osql -E  -i "%rootPath%��Ϸ��¼.sql"
osql -E  -i "%rootPath%��Ϸд��.sql"

set rootPath=1_6˽�˷���\
osql -E  -i "%rootPath%�������.sql"
osql -E  -i "%rootPath%�������.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%��������.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%������Ϣ.sql"
osql -E  -i "%rootPath%����д��.sql"
osql -E  -i "%rootPath%���д��.sql"


echo.
echo *************************************************************************
echo ��ҫ��һ����װ�Ѿ�������ҫ�����ݿ�
echo ����������Ϸ��ʶ����ֱ�ӹر�
echo ��Ҫ������Ϸ��ʶ���밴���������
echo *************************************************************************
pause

CLS
echo.
@echo ������Ϸ��ʶ
set rootPath=1_5������Ϸ��ʶ\
osql -E  -i "%rootPath%��ʶ����.sql"

CLS
@echo off
echo *************************************************************************
echo.
echo ��ҫ��һ����װ�ű�������� 
echo.
echo.
echo ��Ȩ���У� �����в��ƿƼ����޹�˾
echo *************************************************************************

pause


pause


