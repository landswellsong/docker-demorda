# Docker-майнер ДемОрди

## Зібрати самому

Якщо не довіряєте моїй збірці(а не маєте довіряти):

```
docker built -t landswellsong/xmrig_demorda . 
```

Версія для armhf (raspberry pi і тд)

```
docker build . -t landswellsong/xmrig_demorda:armhf -f Dockerfile.armhf
```

## Запустити

Якщо не збирали самі, скачає з DockerHub:
```
docker run -it landswellsong/xmrig_demorda
```
Запуск у фоновому режимі:
```
docker run -d landswellsong/xmrig_demorda
```
## Примітка для arm

Слідкуйте за температурою девайсу, щоб у вашої raspberry не вилізли очі. Скоріш за все є сенс погратись з опціями `--max-cpu-usage`, `--av`, `--threads`, `--cpu-priority` щоб знайти ідеальний баланс температурного режиму і продуктивності.
