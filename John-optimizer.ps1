#Requires -RunAsAdministrator
# =======================================================
#          CENTRAL DE OTIMIZACAO E FERRAMENTAS (PS1)
# =======================================================

function Show-Menu {
    Clear-Host
    $Host.UI.RawUI.WindowTitle = "Central de Otimizacao Windows (PowerShell)"
    Write-Host "=======================================================" -ForegroundColor Cyan
    Write-Host "          CENTRAL DE OTIMIZACAO E FERRAMENTAS" -ForegroundColor Cyan
    Write-Host "=======================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[1] Limpar Arquivos Temporarios e Cache"
    Write-Host "[2] Executar Verificacao e Reparo do Sistema (SFC / DISM)"
    Write-Host "[3] Otimizar e Limpar DNS (Melhorar Conexao)"
    Write-Host "[4] Habilitar Plano de Desempenho Maximo"
    Write-Host "[5] DESATIVAR Windows Update"
    Write-Host "[6] ATIVAR Windows Update (Padrao)"
    Write-Host "[7] Sair"
    Write-Host ""
    Write-Host "=======================================================" -ForegroundColor Cyan
}

function Pause-Script {
    Write-Host ""
    Read-Host "Pressione Enter para continuar..."
}

# Loop principal do Menu
do {
    Show-Menu
    $opcao = Read-Host "Escolha uma opcao (1-7)"

    switch ($opcao) {
        "1" {
            Clear-Host
            Write-Host "[INFO] Iniciando limpeza de arquivos temporarios..." -ForegroundColor Yellow
            Write-Host ""
            
            # Limpando a pasta Temp do Usuario
            if (Test-Path "$env:USERPROFILE\AppData\Local\Temp") {
                Get-ChildItem "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            }
            # Limpando a pasta Temp do Sistema
            if (Test-Path "$env:SystemRoot\Temp") {
                Get-ChildItem "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            }
            # Limpando a pasta Prefetch
            if (Test-Path "$env:SystemRoot\Prefetch") {
                Get-ChildItem "$env:SystemRoot\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            }
            
            Write-Host "[OK] Limpeza concluida com sucesso!" -ForegroundColor Green
            Pause-Script
        }
        "2" {
            Clear-Host
            Write-Host "[INFO] Iniciando ferramentas de diagnostico da Microsoft..." -ForegroundColor Yellow
            Write-Host "Esse processo pode demorar alguns minutos.`n" -ForegroundColor Yellow
            
            Write-Host "Executando SFC (System File Checker)..." -ForegroundColor Cyan
            sfc /scannow
            
            Write-Host "`nExecutando DISM (Reparo de Imagem do Sistema)..." -ForegroundColor Cyan
            dism /online /cleanup-image /restorehealth
            
            Write-Host "`n[OK] Verificacao e reparos concluidos!" -ForegroundColor Green
            Pause-Script
        }
        "3" {
            Clear-Host
            Write-Host "[INFO] Otimizando configuracoes de rede..." -ForegroundColor Yellow
            Write-Host ""
            
            Clear-DnsClientCache -ErrorAction SilentlyContinue
            ipconfig /registerdns | Out-Null
            ipconfig /release | Out-Null
            ipconfig /renew | Out-Null
            netsh int ip reset | Out-Null
            netsh winsock reset | Out-Null
            
            Write-Host "[OK] Cache de DNS limpo e protocolos de rede resetados!" -ForegroundColor Green
            Pause-Script
        }
        "4" {
            Clear-Host
            Write-Host "[INFO] Liberando o plano de energia oculto do Windows..." -ForegroundColor Yellow
            Write-Host ""
            
            powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
            
            Write-Host ""
            Write-Host "[OK] Plano 'Desempenho Maximo' adicionado!" -ForegroundColor Green
            Write-Host "Agora voce pode ativa-lo em: Painel de Controle -> Opcoes de Energia." -ForegroundColor Yellow
            Pause-Script
        }
        "5" {
            Clear-Host
            Write-Host "[INFO] Desativando os servicos do Windows Update..." -ForegroundColor Yellow
            Write-Host ""
            
            # Windows Update
            Stop-Service -Name "wuauserv" -Force -ErrorAction SilentlyContinue
            Set-Service -Name "wuauserv" -StartupType Disabled -ErrorAction SilentlyContinue
            
            # BITS
            Stop-Service -Name "bits" -Force -ErrorAction SilentlyContinue
            Set-Service -Name "bits" -StartupType Disabled -ErrorAction SilentlyContinue
            
            # WaaSMedicSvc (Servico de Medicacao de Atualizacao)
            Stop-Service -Name "WaaSMedicSvc" -Force -ErrorAction SilentlyContinue
            # Alteração segura direta via Registro do provedor nativo do PowerShell
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" -Name "Start" -Value 4 -Force -ErrorAction SilentlyContinue
            
            Write-Host "[OK] Windows Update foi desativado com sucesso!" -ForegroundColor Green
            Write-Host "(Nota: O Windows pode tentar reativar isso sozinho no futuro devido a tarefas agendadas ocultas)." -ForegroundColor DarkYellow
            Pause-Script
        }
        "6" {
            Clear-Host
            Write-Host "[INFO] Ativando e restaurando os servicos do Windows Update..." -ForegroundColor Yellow
            Write-Host ""
            
            Set-Service -Name "wuauserv" -StartupType Manual -ErrorAction SilentlyContinue
            Start-Service -Name "wuauserv" -ErrorAction SilentlyContinue
            
            Set-Service -Name "bits" -StartupType Manual -ErrorAction SilentlyContinue
            Start-Service -Name "bits" -ErrorAction SilentlyContinue
            
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" -Name "Start" -Value 3 -Force -ErrorAction SilentlyContinue
            Start-Service -Name "WaaSMedicSvc" -ErrorAction SilentlyContinue
            
            Write-Host "[OK] Windows Update reativado para o padrao do sistema!" -ForegroundColor Green
            Pause-Script
        }
        "7" {
            Clear-Host
            Write-Host "`nObrigado por usar a central de otimizacao!" -ForegroundColor Cyan
            Start-Sleep -Seconds 2
            break
        }
        default {
            Write-Host "Opcao invalida! Escolha um numero de 1 a 7." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($opcao -ne "7")
