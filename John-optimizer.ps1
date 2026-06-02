#Requires -RunAsAdministrator
# ==============================================================================
#                           John-Optimizer
# ==============================================================================

function Pause-Script {
    Write-Host ""
    Read-Host "Pressione Enter para voltar ao menu..."
}

# --- LOOP PRINCIPAL DO SISTEMA ---
do {
    Clear-Host
    $Host.UI.RawUI.WindowTitle = "Central de Otimização Windows - Menu Principal"
    Write-Host "=======================================================" -ForegroundColor Cyan
    Write-Host "          John-Optimizer" -ForegroundColor Cyan
    Write-Host "=======================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[1] Limpeza de Arquivos e Discos (Opções 1-10)"
    Write-Host "[2] Rede, Internet e Conectividade (Opções 11-20)"
    Write-Host "[3] Desempenho do Sistema e Energia (Opções 21-30)"
    Write-Host "[4] Privacidade, Serviços e Coleta de Dados (Opções 31-40)"
    Write-Host "[5] Jogos e Ajustes Avançados do Windows (Opções 41-50)"
    Write-Host "[6] Sair do Otimizador"
    Write-Host ""
    Write-Host "=======================================================" -ForegroundColor Cyan
    $menuPrincipal = Read-Host "Escolha uma categoria (1-6)"

    switch ($menuPrincipal) {
        # ==============================================================================
        # CATEGORIA 1: LIMPEZA DE ARQUIVOS E DISCOS (1-10)
        # ==============================================================================
        "1" {
            do {
                Clear-Host
                Write-Host "--- CATEGORIA 1: LIMPEZA DE ARQUIVOS E DISCOS ---`n" -ForegroundColor Yellow
                Write-Host "[1] Limpar arquivos temporários do Usuário (%temp%)"
                Write-Host "[2] Limpar arquivos temporários do Sistema (Windows\Temp)"
                Write-Host "[3] Limpar pasta de carregamento Prefetch"
                Write-Host "[4] Esvaziar a Lixeira do Windows automaticamente"
                Write-Host "[5] Limpar cache de miniaturas de imagens (Thumbnails)"
                Write-Host "[6] Limpar histórico de arquivos recentes do Explorador"
                Write-Host "[7] Limpar logs de eventos do Windows (Visualizador de Eventos)"
                Write-Host "[8] Limpar cache de downloads do Windows Update"
                Write-Host "[9] Excluir arquivos de log legados (.log) do sistema"
                Write-Host "[10] Otimizar e desfragmentar unidades de armazenamento"
                Write-Host "[11] Voltar ao Menu Principal"
                Write-Host ""
                $op = Read-Host "Escolha uma opção (1-11)"
                
                switch ($op) {
                    "1" { Clear-Host; Get-ChildItem "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Temp do Usuário limpo!" -ForegroundColor Green; Pause-Script }
                    "2" { Clear-Host; Get-ChildItem "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Temp do Sistema limpo!" -ForegroundColor Green; Pause-Script }
                    "3" { Clear-Host; Get-ChildItem "$env:SystemRoot\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Prefetch limpo!" -ForegroundColor Green; Pause-Script }
                    "4" { Clear-Host; Clear-RecycleBin -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Lixeira esvaziada!" -ForegroundColor Green; Pause-Script }
                    "5" { Clear-Host; Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue; Get-ChildItem "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" -Force -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue; Start-Process explorer; Write-Host "[OK] Cache de miniaturas limpo!" -ForegroundColor Green; Pause-Script }
                    "6" { Clear-Host; Remove-Item "$env:APPDATA\Microsoft\Windows\Recent\*" -Recurse -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Histórico recente limpo!" -ForegroundColor Green; Pause-Script }
                    "7" { Clear-Host; Get-EventLog -LogName * | ForEach-Object { Clear-EventLog $_.Log } -ErrorAction SilentlyContinue; Write-Host "[OK] Logs do sistema limpos!" -ForegroundColor Green; Pause-Script }
                    "8" { Clear-Host; Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue; Remove-Item "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue; Start-Service -Name wuauserv -ErrorAction SilentlyContinue; Write-Host "[OK] Cache do Windows Update limpo!" -ForegroundColor Green; Pause-Script }
                    "9" { Clear-Host; Get-ChildItem -Path "C:\" -Filter "*.log" -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Logs redundantes excluídos!" -ForegroundColor Green; Pause-Script }
                    "10" { Clear-Host; Write-Host "Analisando/Otimizando volumes..."; Optimize-Volume -DriveLetter C -Defrag -Verbose -ErrorAction SilentlyContinue; Write-Host "[OK] Otimização concluída!" -ForegroundColor Green; Pause-Script }
                }
            } while ($op -ne "11")
        }

        # ==============================================================================
        # CATEGORIA 2: REDE, INTERNET E CONECTIVIDADE (11-20)
        # ==============================================================================
        "2" {
            do {
                Clear-Host
                Write-Host "--- CATEGORIA 2: REDE, INTERNET E CONECTIVIDADE ---`n" -ForegroundColor Yellow
                Write-Host "[12] Limpar cache de resolução DNS"
                Write-Host "[13] Redefinir protocolos de rede TCP/IP"
                Write-Host "[14] Redefinir catálogo de sockets do Winsock"
                Write-Host "[15] Liberar endereço IP atual (Release)"
                Write-Host "[16] Renovar endereço IP atual (Renew)"
                Write-Host "[17] Otimizar ajuste automático da janela de recepção TCP"
                Write-Host "[18] Desativar Otimização de Entrega do Windows Update (P2P de banda)"
                Write-Host "[19] Restaurar regras padrão do Firewall do Windows"
                Write-Host "[20] Desativar limitação de rede para multimídia/jogos"
                Write-Host "[21] Forçar atualização das Diretivas de Grupo (GPUpdate)"
                Write-Host "[22] Voltar ao Menu Principal"
                Write-Host ""
                $op = Read-Host "Escolha uma opção (12-22)"

                switch ($op) {
                    "12" { Clear-Host; Clear-DnsClientCache -ErrorAction SilentlyContinue; Write-Host "[OK] Cache DNS limpo!" -ForegroundColor Green; Pause-Script }
                    "13" { Clear-Host; netsh int ip reset | Out-Null; Write-Host "[OK] TCP/IP redefinido!" -ForegroundColor Green; Pause-Script }
                    "14" { Clear-Host; netsh winsock reset | Out-Null; Write-Host "[OK] Catálogo Winsock limpo!" -ForegroundColor Green; Pause-Script }
                    "15" { Clear-Host; ipconfig /release | Out-Null; Write-Host "[OK] IP Liberado!" -ForegroundColor Green; Pause-Script }
                    "16" { Clear-Host; ipconfig /renew | Out-Null; Write-Host "[OK] IP Renovado!" -ForegroundColor Green; Pause-Script }
                    "17" { Clear-Host; netsh int tcp set global autotuninglevel=normal | Out-Null; Write-Host "[OK] TCP AutoTuning otimizado!" -ForegroundColor Green; Pause-Script }
                    "18" { Clear-Host; Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Compartilhamento P2P desativado!" -ForegroundColor Green; Pause-Script }
                    "19" { Clear-Host; netsh advfirewall reset | Out-Null; Write-Host "[OK] Firewall redefinido de fábrica!" -ForegroundColor Green; Pause-Script }
                    "20" { Clear-Host; Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Limitação de rede removida!" -ForegroundColor Green; Pause-Script }
                    "21" { Clear-Host; gpupdate /force; Write-Host "[OK] Diretivas atualizadas!" -ForegroundColor Green; Pause-Script }
                }
            } while ($op -ne "22")
        }

        # ==============================================================================
        # CATEGORIA 3: DESEMPENHO DO SISTEMA E ENERGIA (21-30)
        # ==============================================================================
        "3" {
            do {
                Clear-Host
                Write-Host "--- CATEGORIA 3: DESEMPENHO DO SISTEMA E ENERGIA ---`n" -ForegroundColor Yellow
                Write-Host "[23] Injetar e ativar o plano de Desempenho Máximo"
                Write-Host "[24] Desativar a Hibernação do sistema (Libera espaço em SSD)"
                Write-Host "[25] Reativar a Hibernação do sistema"
                Write-Host "[26] Desativar a Inicialização Rápida (Previne retenção de erros no Kernel)"
                Write-Host "[27] Acelerar encerramento de processos travados no desligamento"
                Write-Host "[28] Alocar prioridade do processador para Programas (Primeiro plano)"
                Write-Host "[29] Desativar sombras sob as janelas e ponteiro do mouse"
                Write-Host "[30] Desativar efeitos visuais de esmaecimento e animações"
                Write-Host "[31] Desativar efeitos de transparência das janelas (Aero)"
                Write-Host "[32] Reduzir tempo de resposta ao abrir menus flutuantes"
                Write-Host "[33] Voltar ao Menu Principal"
                Write-Host ""
                $op = Read-Host "Escolha uma opção (23-33)"

                switch ($op) {
                    "23" { Clear-Host; powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null; Write-Host "[OK] Plano Desempenho Máximo liberado nas configurações!" -ForegroundColor Green; Pause-Script }
                    "24" { Clear-Host; powercfg -h off; Write-Host "[OK] Hibernação desativada! Espaço em disco recuperado." -ForegroundColor Green; Pause-Script }
                    "25" { Clear-Host; powercfg -h on; Write-Host "[OK] Hibernação reativada!" -ForegroundColor Green; Pause-Script }
                    "26" { Clear-Host; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Inicialização rápida desativada!" -ForegroundColor Green; Pause-Script }
                    "27" { Clear-Host; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value "2000" -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Desligamento acelerado!" -ForegroundColor Green; Pause-Script }
                    "28" { Clear-Host; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Value 38 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Foco ajustado para aplicativos ativos!" -ForegroundColor Green; Pause-Script }
                    "29" { Clear-Host; Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x90,0x12,0x03,0x80,0x10,0x00,0x00,0x00)) -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Sombras visuais removidas!" -ForegroundColor Green; Pause-Script }
                    "30" { Clear-Host; Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value "0" -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Animações desativadas!" -ForegroundColor Green; Pause-Script }
                    "31" { Clear-Host; Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Transparência desativada!" -ForegroundColor Green; Pause-Script }
                    "32" { Clear-Host; Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Atraso do menu zerado!" -ForegroundColor Green; Pause-Script }
                }
            } while ($op -ne "33")
        }

        # ==============================================================================
        # CATEGORIA 4: PRIVACIDADE, SERVIÇOS E COLETA DE DADOS (31-40)
        # ==============================================================================
        "4" {
            do {
                Clear-Host
                Write-Host "--- CATEGORIA 4: PRIVACIDADE, SERVIÇOS E COLETA DE DADOS ---`n" -ForegroundColor Yellow
                Write-Host "[34] Desativar serviço SysMain / Superfetch (Evita 100% de uso de disco em HDs)"
                Write-Host "[35] Ativar serviço SysMain / Superfetch (Padrão do sistema)"
                Write-Host "[36] Desativar o Windows Search (Para computadores muito antigos/lentos)"
                Write-Host "[37] Ativar o Windows Search"
                Write-Host "[38] Bloquear coleta de telemetria geral da Microsoft"
                Write-Host "[39] Desativar Serviço de Experiências de Usuário Conectado (DiagTrack)"
                Write-Host "[40] Desativar serviço de Relatório de Erros do Windows (WerSvc)"
                Write-Host "[41] Desativar serviço de downloads automáticos de mapas offline"
                Write-Host "[42] Desativar envio de dicas, truques e sugestões do Windows"
                Write-Host "[43] Desativar o recurso de Assistência Remota nativo"
                Write-Host "[44] Voltar ao Menu Principal"
                Write-Host ""
                $op = Read-Host "Escolha uma opção (34-44)"

                switch ($op) {
                    "34" { Clear-Host; Stop-Service -Name "SysMain" -Force -ErrorAction SilentlyContinue; Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue; Write-Host "[OK] SysMain desativado!" -ForegroundColor Green; Pause-Script }
                    "35" { Clear-Host; Set-Service -Name "SysMain" -StartupType Automatic -ErrorAction SilentlyContinue; Start-Service -Name "SysMain" -ErrorAction SilentlyContinue; Write-Host "[OK] SysMain ativado!" -ForegroundColor Green; Pause-Script }
                    "36" { Clear-Host; Stop-Service -Name "WSearch" -Force -ErrorAction SilentlyContinue; Set-Service -Name "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue; Write-Host "[OK] Indexação do Windows Search paralisada!" -ForegroundColor Green; Pause-Script }
                    "37" { Clear-Host; Set-Service -Name "WSearch" -StartupType Automatic -ErrorAction SilentlyContinue; Start-Service -Name "WSearch" -ErrorAction SilentlyContinue; Write-Host "[OK] Windows Search ativado!" -ForegroundColor Green; Pause-Script }
                    "38" { Clear-Host; Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Telemetria bloqueada!" -ForegroundColor Green; Pause-Script }
                    "39" { Clear-Host; Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue; Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue; Write-Host "[OK] Serviço DiagTrack desativado!" -ForegroundColor Green; Pause-Script }
                    "40" { Clear-Host; Stop-Service -Name "WerSvc" -Force -ErrorAction SilentlyContinue; Set-Service -Name "WerSvc" -StartupType Disabled -ErrorAction SilentlyContinue; Write-Host "[OK] Relatório de Erros desativado!" -ForegroundColor Green; Pause-Script }
                    "41" { Clear-Host; Stop-Service -Name "MapsBroker" -Force -ErrorAction SilentlyContinue; Set-Service -Name "MapsBroker" -StartupType Disabled -ErrorAction SilentlyContinue; Write-Host "[OK] Gerenciador de mapas desativado!" -ForegroundColor Green; Pause-Script }
                    "42" { Clear-Host; Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Sugestões comerciais desativadas!" -ForegroundColor Green; Pause-Script }
                    "43" { Clear-Host; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\RemoteAssistance" -Name "fAllowToGetHelp" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Assistência Remota bloqueada!" -ForegroundColor Green; Pause-Script }
                }
            } while ($op -ne "44")
        }

        # ==============================================================================
        # CATEGORIA 5: JOGOS E AJUSTES AVANÇADOS DO WINDOWS (41-50)
        # ==============================================================================
        "5" {
            do {
                Clear-Host
                Write-Host "--- CATEGORIA 5: JOGOS E AJUSTES AVANÇADOS ---`n" -ForegroundColor Yellow
                Write-Host "[45] Ativar o Modo de Jogo nativo (Game Mode)"
                Write-Host "[46] Desativar a Xbox Game Bar em segundo plano"
                Write-Host "[47] Desativar gravação de clipes em jogos (Game DVR)"
                Write-Host "[48] Limpar e redefinir o cache da Microsoft Store"
                Write-Host "[49] Remover aplicativos Bloatware nativos de fábrica do usuário atual"
                Write-Host "[50] Bloquear a execução de aplicativos universais em segundo plano"
                Write-Host "[51] Desativar tarefas agendadas de coleta de experiência de software"
                Write-Host "[52] Otimizar alocação de cache de memória para partições NTFS"
                Write-Host "[53] DESATIVAR os serviços do Windows Update completamente"
                Write-Host "[54] ATIVAR os serviços do Windows Update"
                Write-Host "[55] Voltar ao Menu Principal"
                Write-Host ""
                $op = Read-Host "Escolha uma opção (45-55)"

                switch ($op) {
                    "45" { Clear-Host; Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Modo de Jogo ativado!" -ForegroundColor Green; Pause-Script }
                    "46" { Clear-Host; Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Xbox Game Bar desligada!" -ForegroundColor Green; Pause-Script }
                    "47" { Clear-Host; Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Gravação Game DVR desativada!" -ForegroundColor Green; Pause-Script }
                    "48" { Clear-Host; Write-Host "Redefinindo a Loja..."; & wsreset.exe; Start-Sleep -Seconds 3; Write-Host "[OK] Cache limpo!" -ForegroundColor Green; Pause-Script }
                    "49" { Clear-Host; Write-Host "Removendo bloatwares (pode demorar)..."; Get-AppxPackage -AllUsers | Where-Object {$_.Name -Match "33927Caniproject|BingWeather|GetHelp|Getstarted|MicrosoftSolitaireCollection|OfficeHub|SkypeApp|ZuneVideo|ZuneMusic"} | Remove-AppxPackage -ErrorAction SilentlyContinue; Write-Host "[OK] Aplicativos inúteis removidos!" -ForegroundColor Green; Pause-Script }
                    "50" { Clear-Host; Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Apps em segundo plano bloqueados!" -ForegroundColor Green; Pause-Script }
                    "51" { Clear-Host; Disable-ScheduledTask -TaskName "ConsolidatedTelemetry" -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" -ErrorAction SilentlyContinue; Write-Host "[OK] Tarefas de telemetria desativadas!" -ForegroundColor Green; Pause-Script }
                    "52" { Clear-Host; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "NtfsMemoryUsage" -Value 2 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Uso de memória NTFS otimizado!" -ForegroundColor Green; Pause-Script }
                    "53" { Clear-Host; Stop-Service -Name "wuauserv","bits" -Force -ErrorAction SilentlyContinue; Set-Service -Name "wuauserv","bits" -StartupType Disabled -ErrorAction SilentlyContinue; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" -Name "Start" -Value 4 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Windows Update totalmente bloqueado!" -ForegroundColor Green; Pause-Script }
                    "54" { Clear-Host; Set-Service -Name "wuauserv","bits" -StartupType Manual -ErrorAction SilentlyContinue; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" -Name "Start" -Value 3 -Force -ErrorAction SilentlyContinue; Write-Host "[OK] Componentes do Windows Update restaurados!" -ForegroundColor Green; Pause-Script }
                }
            } while ($op -ne "55")
        }

        "6" {
            Clear-Host
            Write-Host "`nObrigado por utilizar a Central de Otimização Avançada!" -ForegroundColor Cyan
            Start-Sleep -Seconds 2
            break
        }
    }
} while ($menuPrincipal -ne "6")
