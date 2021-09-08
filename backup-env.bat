set day=%date:~0,2%
set month=%date:~3,2%
set year=%date:~-4%
set file_name=backup-%day%-%month%-%year%.sql 

cd /D %current_dir%\backup

mysqldump -u %username% --password=%password% %database% > db\%file_name%

git branch backup
git checkout backup
git add .
git commit -m "backup-%day%-%month%-%year%"
git push --set-upstream origin backup
git push origin

exit
