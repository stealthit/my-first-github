@echo off
chcp 65001 >nul
echo Git 커밋을 진행합니다...
echo.

git --version >nul 2>&1
if errorlevel 1 (
    echo 오류: Git이 설치되어 있지 않거나 PATH에 없습니다.
    echo Git을 설치해주세요: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo Git 저장소 상태 확인 중...
git status

echo.
echo 파일 추가 중...
git add index.html style.css

echo.
echo 커밋 중...
git commit -m "Add index.html and separate style.css file"

if errorlevel 0 (
    echo.
    echo 커밋 완료! ✓
) else (
    echo.
    echo 커밋 실패. 변경사항이 없거나 오류가 발생했습니다.
)

pause

