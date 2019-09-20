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

// vlc 설정 변경
func changeConfig(key string, value string) {

	// 변경하려는 설정 항목이 있는지 확인
	cmd := "grep " + key + " " + VLCCONFIG
	out, err := exec.Command("/bin/sh", "-c", cmd).Output()
	if err != nil {
		fmt.Println(err)
	}

	// 있으면 바꾸고, 없으면 추가
	if string(out[:]) != "" {
		cmd = fmt.Sprintf("sed -i 's/^#\\?%s.*/%s=%s/g' %s", key, key, value, VLCCONFIG)
		_, err := exec.Command("/bin/sh", "-c", cmd).Output()
		if err != nil {
			fmt.Println(err)
		}
	} else {
		cmd = fmt.Sprintf("echo '\n# %s\n%s=%s' >> %s", key, key, value, VLCCONFIG)
		_, err := exec.Command("/bin/sh", "-c", cmd).Output()
		if err != nil {
			fmt.Println(err)
		}
	}
}
