package main

import (
	"fmt"
	"os/exec"
	"runtime"
)

const VLCCONFIG = "$HOME/.config/vlc/vlcrc"

func main() {
	if runtime.GOOS == "windows" {
		fmt.Println("Can't Execute this on a windows machine")
	} else {
		changeConfig("extraintf", "http")     // 인터페이스에 web(http) 추가
		changeConfig("http-password", "1234") // http 암호 변경
		changeConfig("http-port", "9090")     // 포트번호 변경
	}
}

func changeConfig(keyword string, value string) {
	cmd := "grep " + keyword + " " + VLCCONFIG
	out, err := exec.Command("/bin/sh", "-c", cmd).Output()
	if err != nil {
		fmt.Println(err)
	}

	if string(out[:]) != "" {
		cmd = fmt.Sprintf("sed -ie 's/.%s.*/%s=%s/g' %s", keyword, keyword, value, VLCCONFIG)
		_, err := exec.Command("/bin/sh", "-c", cmd).Output()
		if err != nil {
			fmt.Println(err)
		}
	}
}
