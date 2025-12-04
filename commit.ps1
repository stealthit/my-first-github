# Git 커밋 스크립트
# 이 스크립트는 index.html과 style.css를 Git에 추가하고 커밋합니다.

Write-Host "Git 저장소 상태 확인 중..." -ForegroundColor Cyan

# Git이 설치되어 있는지 확인
$gitCmd = $null
$possiblePaths = @(
    "git",
    "C:\Program Files\Git\cmd\git.exe",
    "C:\Program Files (x86)\Git\cmd\git.exe",
    "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe",
    "$env:USERPROFILE\AppData\Local\Programs\Git\cmd\git.exe"
)

foreach ($path in $possiblePaths) {
    try {
        if ($path -eq "git") {
            $result = Get-Command git -ErrorAction SilentlyContinue
            if ($result) {
                $gitCmd = "git"
                break
            }
        } else {
            if (Test-Path $path) {
                $gitCmd = $path
                break
            }
        }
    } catch {
        continue
    }
}

if (-not $gitCmd) {
    Write-Host "오류: Git이 설치되어 있지 않거나 PATH에 없습니다." -ForegroundColor Red
    Write-Host "Git을 설치해주세요: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host "Git 발견: $gitCmd" -ForegroundColor Green

# 저장소 초기화 (이미 초기화되어 있으면 스킵)
if (-not (Test-Path .git)) {
    Write-Host "Git 저장소 초기화 중..." -ForegroundColor Cyan
    & $gitCmd init
}

# 파일 추가
Write-Host "파일 추가 중..." -ForegroundColor Cyan
& $gitCmd add index.html style.css

# 상태 확인
Write-Host "`n저장소 상태:" -ForegroundColor Cyan
& $gitCmd status

# 커밋
Write-Host "`n커밋 중..." -ForegroundColor Cyan
$commitMessage = "Add index.html and separate style.css file"
& $gitCmd commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n커밋 완료! ✓" -ForegroundColor Green
    Write-Host "커밋 메시지: $commitMessage" -ForegroundColor Green
} else {
    Write-Host "`n커밋 실패. 변경사항이 없거나 오류가 발생했습니다." -ForegroundColor Yellow
}

