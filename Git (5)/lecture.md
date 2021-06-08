Веб-тренажер: https://learngitbranching.js.org/?locale=ru_RU
Документация: https://git-scm.com/doc
Книга: https://git-scm.com/book/en/v2 

git clone <url> : копирование репозитория по ссылке
-	https url : лайт копирование без возможности отправить изменения на сервер без авторизации
-	ssh url : необходимо предварительно зафиксировать ssh-ключ (можно сгенерировать через ssh-keygen, например) устройства на сервере. Позволяет сразу отправлять изменения на сервер.
-	https://git-scm.com/docs/git-clone 

git config : настройка Git на локальной машине
-	--global : настройка глобальных параметров, например user.email <email>
-	https://git-scm.com/docs/git-config 

README.md : стандартный файл при создании репозитория на GitHub. Сайт поддерживает обработку Markdown.

git status : отображает статус рабочего дерева
-	-b / --branch : отображает статус используемой ветки
-	https://git-scm.com/docs/git-status 

git add <filename> : выделение файла для будущего коммита
-	. : выделение всех измененных файлов для будущего коммита
-	https://git-scm.com/docs/git-add 

git commit : фиксация выделенных изменений на локальной машине
-	-m <message> / --message=<msg> : комментарий к коммиту
-	https://git-scm.com/docs/git-commit

git push : отправка зафиксированных изменений на сервер
-	--progress : статус выполнения команды
-	origin <branchname> отправка новой ветки на сервер
-	origin --delete <branchname> удаление ветки с сервера
-	https://git-scm.com/docs/git-push 

origin/main ( <remote>/<branch> ) : ветка слежения. Подробнее https://git-scm.com/book/en/v2/Git-Branching-Remote-Branches

git branch : управление ветками (список, создание, удаление)
-	<branchname> : создание ветки
-	-d <branchname> : удаление ветки
-	-a  : вывод всех веток
-	https://git-scm.com/docs/git-branch 

git checkout : смена веток
-	<branchname> : перемещение на ветку
-	-b <branchname>: создание и перемещение на созданную ветку

git fetch : получение изменений с сервера. Подробнее https://git-scm.com/docs/git-fetch 

git pull : получение и загрузка изменений с сервера. Подробнее https://git-scm.com/docs/git-pull 

git merge : объединение веток. Подробнее https://git-scm.com/docs/git-merge 

git reset : сброс текущего HEAD в выбранное состояние:
-	HEAD^: перемещение на шаг назад от HEAD. ^x – перемещение на x шагов назад. ~x – перемещение на ветку под номером х с коммита объединения веток.
-	--hard : сброс индекса и рабочего дерева.
-	https://git-scm.com/docs/git-reset 

git log : отображение журнала коммитов. Подробнее https://git-scm.com/docs/git-log 

git revert : отмена нескольких существующих коммитов (можно указать через индекс коммита, а также через перемещение с помощью ~). Подробнее https://git-scm.com/docs/git-revert 

git stash : сохранение неподтвержденных изменений, чтобы к ним можно было вернуться позже
-	apply : применение сохраненных изменений
-	https://git-scm.com/docs/git-stash 

pull request : запрос на внесение изменений в ветку, на которую нет прав доступа. Подробнее https://git-scm.com/book/en/v2/GitHub-Contributing-to-a-Project 

