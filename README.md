# ssl-checker

## Install
create a symbolic link in a directory on your `PATH`
```sh
$ git clone git@github.com:dafract/ssl-checker.git
$ ln -s "$(pwd)/ssl-checker/ssl-check.sh" /usr/local/bin/ssl-check
```

then you can run it as a command
```sh
$ ssl-check www.example.com
```

## How to use
run the following command
```sh
$ ssl-check <FQDN> [IP] [PORT]
```

| argument | description | default |
| --- | --- | --- |
| `FQDN` | hostname to check (also used for SNI) | (required) |
| `IP` | target IP address | all A records resolved by `dig` |
| `PORT` | target port | `443` |

`PORT` is positional, so `IP` must be given to specify it
```sh
$ ssl-check www.example.com 93.184.216.34 8443
```

then you will get the following response
```
93.184.216.34
subject= /C=US/ST=California/L=Los Angeles/O=Internet\xC2\xA0Corporation\xC2\xA0for\xC2\xA0Assigned\xC2\xA0Names\xC2\xA0and\xC2\xA0Numbers/CN=www.example.org
notBefore=Jan 13 00:00:00 2023 GMT
notAfter=Feb 13 23:59:59 2024 GMT
    Verify return code: 0 (ok)
remaining: 270 days
```

