This is a all-in-one docker image for [clarencep/xhgui](https://github.com/clarencep/xhgui). 

It is easy to run:
```
docker run -d -p 8880:80 -P clarencep/xhgui
```

The you can visit <http://localhost:8880> to view the xhgui.

The source code of [clarencep/xhgui](https://github.com/clarencep/xhgui) is in `/var/www/xhgui`. You may use data volume to overwrite it.
```
docker run -d -p 8880:80 -P -v /path/to/your/xhgui:/var/www/xhgui clarencep/xhgui
```
B.t.w, the data file of mongodb is in `/data/mongodb`.

