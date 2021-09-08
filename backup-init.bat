@REM request input init db
set /P username=db username:
set /P password=db password (gunakan "" jika kosong):
set /P database=db name:
set /P time=time backup (hh:ss):

@REM make folder backup
mkdir backup\db
mkdir backup\init

@REM for reinit
type nul > backup\init\backup-start.bat
type nul > backup\init\backup.bat

@REM finishing init
echo | set /P="set current_dir=%cd%"    >> backup\init\backup.bat
echo.                                   >> backup\init\backup.bat
echo | set /P="set username=%username%" >> backup\init\backup.bat
echo.                                   >> backup\init\backup.bat
echo | set /P="set password=%password%" >> backup\init\backup.bat
echo.                                   >> backup\init\backup.bat
echo | set /P="set database=%database%" >> backup\init\backup.bat
echo.                                   >> backup\init\backup.bat
type backup-env.bat                     >> backup\init\backup.bat

@REM create tasks for tasks scheduler
echo | set /P=start /min "" "%cd%\backup\init\backup.bat" > backup\init\backup-start.bat
SCHTASKS /CREATE /SC DAILY /TN "UPK\Backup Database" /TR "%cd%\backup\init\backup-start.bat" /ST %time%