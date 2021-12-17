@echo off
echo --- IEエンタープライズモードサイトリストのバージョンを調べる ---
echo.
echo ============
echo Internet Explorer 11 が起動してから約 65 秒後、サイト一覧のバージョンが保存されたバージョン番号と比較されます。ファイルの番号の方が大きい場合、新しいバージョンが読み込まれます。
echo.
echo [重要]
echo この確認の後、ブラウザーを再起動するまで、IE11 は更新された一覧を検索しません。
echo.
echo Approximately 65 seconds after Internet Explorer 11 starts, it compares your site list version to the stored version number. If your file has a higher number, the newer version is loaded.
echo.
echo Important
echo After this check, IE11 won’t look for an updated list again until you restart the browser.
echo ============
echo.

rem サイト一覧を最新の状態に維持するためには、IE を開いた後 65 秒間待機してから、HKEY\CURRENT\USER\Software\Microsoft\Internet Explorer\Main\EnterpriseMode\ レジストリ キーの CurrentVersion 値がファイル内のバージョン番号と一致することを確認します。
rem "HKEY_CURRENT_USER ==> HKCU"
rem reg query "HKCU\Software\Microsoft\Internet Explorer\Main\EnterpriseMode" /v "CurrentVersion"

echo IEが保持している現在のバージョンは、
for /f "tokens=3" %%A in ('reg query "HKCU\Software\Microsoft\Internet Explorer\Main\EnterpriseMode" /v "CurrentVersion"') do set REG_RESULT=%%A
echo   version=%REG_RESULT%
echo.

echo サイトリスト.xmlを更新するときは、
set /a nextVersion=%REG_RESULT%+1
echo   version=%nextVersion%  にする。
echo.


choice /t 300 /d Y /m "終了しますか？"

if %ERRORLEVEL% equ 2 (
    echo.
    echo IEが新しいバージョンを参照するか確認

    for /f "tokens=3" %%A in ('reg query "HKCU\Software\Microsoft\Internet Explorer\Main\EnterpriseMode" /v "CurrentVersion"') do set REG_RESULT=%%A
    echo +++ version=%REG_RESULT% +++

    start "" "C:\Program Files\Internet Explorer\iexplore.exe"
    timeout /t 70 /nobreak

    for /f "tokens=3" %%A in ('reg query "HKCU\Software\Microsoft\Internet Explorer\Main\EnterpriseMode" /v "CurrentVersion"') do set REG_RESULT=%%A
    echo +++ version=%REG_RESULT% +++

    echo.
    echo XMLのバージョンと一致していれば、OK
    pause
)
