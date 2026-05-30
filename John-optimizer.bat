@echo off
:: Garante que o script está rodando como Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ERRO] Por favor, execute este script como ADMINISTRADOR!
    echo Clique com o botao direito no arquivo e selecione "Executar como Administrador".
    echo.
    pause
    exit /b
)

:menu
cls
title Central de Otimizacao Windows
echo =======================================================
echo          CENTRAL DE OTIMIZACAO E FERRAMENTAS
echo =======================================================
echo.
echo [1] Limpar Arquivos Temporarios e Cache
echo [2] Executar Verificacao e Reparo do Sistema (SFC / DISM)
echo [3] Otimizar e Limpar DNS (Melhorar Conexao)
echo [4] Habilitar Plano de Desempenho Maximo
echo [5] DESATIVAR Windows Update
echo [6] ATIVAR Windows Update (Padrao)
echo [7] Sair
echo.
echo =======================================================
set /p opcao="Escolha uma opcao (1-7): "

if "%opcao%"=="1" goto limpeza
if "%opcao%"=="2" goto reparo
if "%opcao%"=="3" goto dns
if "%opcao%"=="4" goto desempenhomax
if "%opcao%"=="5" goto desativarupdate
if "%opcao%"=="6" goto ativarupdate
if "%opcao%"=="7" goto sair

:limpeza
cls
echo.
echo [INFO] Iniciando limpeza de arquivos temporarios...
echo.
del /s /f /q %userprofile%\AppData\Local\Temp\*.* >nul 2>&1
rd /s /q %userprofile%\AppData\Local\Temp            >nul 2>&1
del /s /f /q %systemroot%\Temp\*.* >nul 2>&1
rd /s /q %systemroot%\Temp                            >nul 2>&1
del /s /f /q %systemroot%\Prefetch\*.* >nul 2>&1
rd /s /q %systemroot%\Prefetch                        >nul 2>&1
echo [OK] Limpeza concluida com sucesso!
pause
goto menu

:reparo
cls
echo.
echo [INFO] Iniciando ferramentas de diagnostico da Microsoft...
echo Esse processo pode demorar alguns minutos.
echo.
echo Executando SFC (System File Checker)...
sfc /scannow
echo.
echo Executando DISM (Reparo de Imagem do Sistema)...
dism /online /cleanup-image /restorehealth
echo.
echo [OK] Verificacao e reparos concluidos!
pause
goto menu

:dns
cls
echo.
echo [INFO] Otimizando configuracoes de rede...
echo.
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh int ip reset
netsh winsock reset
echo.
echo [OK] Cache de DNS limpo e protocolos de rede resetados!
pause
goto menu

:desempenhomax
cls
echo.
echo [INFO] Liberando o plano de energia oculto do Windows...
echo.
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo [OK] Plano "Desempenho Maximo" adicionado! 
echo Agora voce pode ativa-lo em: Painel de Controle -> Opcoes de Energia.
pause
goto menu

:desativarupdate
cls
echo.
echo [INFO] Desativando os servicos do Windows Update...
echo.
:: Para e desativa o servico do Windows Update
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1

:: Para e desativa o Servico de Transferencia Inteligente em Plano de Fundo (BITS)
net stop bits >nul 2>&1
sc config bits start= disabled >nul 2>&1

:: Para e desativa o Servico de Medicacao de Atualizacao do Windows
net stop waasmedic_svc >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

echo [OK] Windows Update foi desativado com sucesso!
echo (Nota: O Windows pode tentar reativar isso sozinho no futuro devido a tarefas agendadas ocultas).
pause
goto menu

:ativarupdate
cls
echo.
echo [INFO] Ativando e restaurando os servicos do Windows Update...
echo.
sc config wuauserv start= demand >nul 2>&1
net start wuauserv >nul 2>&1

sc config bits start= demand >nul 2>&1
net start bits >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
net start waasmedic_svc >nul 2>&1

echo [OK] Windows Update reativado para o padrao do sistema!
pause
goto menu

:sair
cls
echo.
echo Obrigado por usar a central de otimizacao!
echo.
pause
exit