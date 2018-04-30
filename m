Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZrmbxfi8LTzqWqdzzo7JYJc4Ja1owc+IxXq3uGmN79ftCi9vqF9YeXlGr7TzpIiOT4nVquF
ARC-Seal: i=1; a=rsa-sha256; t=1525096157; cv=none;
        d=google.com; s=arc-20160816;
        b=heXXHWC/SDRpVB22UP0s3e9fhzZH1XEMlFJK9tdyptY+9a5NEjenm7qc+jCHKGUKTg
         0V2d6Oi2xz0qnxPMNFLYwjH+2/QndPkyhLRRWULF5lBhKt6mNHQNk/l/3y5oNsgXmaMt
         lOyQoDaZ5hqOz/wdqrlL3u/6voPzPiroy7/ncE2j6SwhAoyWGnmdT+Llxahhd7f4HWOl
         qANNtDhV0CZxUZqQMpBXRQkGlU3p8CAw2QLNOSx81yY2QO+5UJzCypIMMCN6FauZPEzI
         6kZuHdktrxEoKqN8U+cO8FwZwVPfNA76lpjDMqYoYL4mP9Llz8k/P7aITMa+vXVVbOKY
         qzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=2suInXQW5A+6cmVWnv4MN8xkp4b5untYE6ZiThx2acs=;
        b=hPmHp1k+BI/9gvBy3i6XRNfMOaQpJw/aO3sIUJbmmJA/Kcw3GL1Pfmzsg+w/lp+55O
         afHsEGmIvw7VjMXAkSHNducIAPEwsMs8DqZoS4DjX4bVUUaDoqxKajhPXSuu0lYDS43P
         xvTUR2Tk36QDTJ3eBfoAfSKsjEDdWXMxiZPXbAGMy5LVKwizdZWtZCmNGM3iXHoQlorQ
         /biUMAkzDhQVI2bJU/tbAC/1Ex+Xt6RZ4Jss4p/f5i98oUyChhZWuxbWuKH4AH8tkFz6
         P0KR18U0+X3TeGGO4CaeeUCuaCX1OM1f+WNvaU8OunDxUDEgSLhR30FftGHl4zN19+ct
         b8Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.15 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.15.15 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: wii_defconfig: Enable GPIO-related options
Date: Mon, 30 Apr 2018 15:42:47 +0200
Message-Id: <20180430134252.17345-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430134252.17345-1-j.neuschaefer@gmx.net>
References: <20180430134252.17345-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rWe36HgdugXj3/q1Zbt4RExNeCkpOJvkqGu0mf83EALnCTyndqx
 zJmL3zFlIaA5uUKgxSgMjVvKOrPVoPAsc8ETuIIHXlcnIzvXOqeypGH9ryyxyimMmzWOQt0
 ueEQkVf0fFipuuqEEdY73cPFuD4C2SI9h1Syd481AbHdVOJAApJgxwRf5nHEAgWsGUYqtL+
 gxB47HIUkdt454/LcK5VQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SWx3qfTIpUs=:roqtkgGRobpJ6I/I1Tu2VK
 HWqWth7ZR2V8QqgaBz2Dti5iaPWbpcUXWoilC+HyQl2XWZ2fMc91RQFaz4uMKO8iRXL0XAWYw
 Myyw8FM2qP3Vu/ax/yuB9GeYhn5S3KZKXKt6BUKkqa8MIUY+ChCtWRbl4tTjNbDRU7e1P5icq
 mFoma60aMupNSnVWwWMLa1bFazJgwlaqwHUNKToKVciub2fMIv4A6FqdWwl2z+G5n+nU8TeTx
 a+orN7UBLcIxbVKAEc/meyKP2Mcnp0lgCCuh+NIIX5xq/nd6on8X6Y4EYsSljTiiqSAV/wWlb
 hnL55J6mx2fzolC5pbbV4GqfyTYFnnahd3j1eG6l+Kcsq1xpaYE1BJ2RHfL9QXgRXhV8qJVMR
 6J5RNku1RnUoYBqeB3P2BaWAPkDiQdkS1DMVExG1N/6YRZ9CSlKoUx2J9EqCFTjzux2CM6LJf
 lmwDVLmMFWBd68a6gdMWIF7/JGnPUE9JC5pZwn8lq6pitwWBaaDE2ueLMeDE5T3Smr9IShJRw
 RzMFn3+WYbtRtDLju7HkfsXOaot2TwU17i9ktsZ1LFBRZiEWmSyg2H58KlF10jJRaFcisYndY
 ZYvbuZbKNdEsK8FBBcFITj6XTfizq23Xu6gF0bdZib+CU56rHw9C3jo+5OheFolNpiys7pUS9
 oUSTLOaJoBdSkegz27dKqau0cfXl4+HAu6fuvG/e/Kfz2L8TgbapWkk1JM7rTVnT6EBvcMCxZ
 adE2/U4jY3ZSLw+8DbhCxeMvTbBNS6zDaEVrbwtOV4WwG1wmQwCOF2mD5NdFHP6yEAEdRyz6m
 DcQueQq
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599179228553644681?=
X-GMAIL-MSGID: =?utf-8?q?1599179228553644681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that there's a GPIO driver for the Wii, let's enable the following
drivers:

- the GPIO driver itself
- gpio-keys
- gpio-poweroff
- gpio-leds and a few LED triggers

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/configs/wii_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 3167b9d7f3e5..40a3b5c09765 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -58,6 +58,7 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_MISC=y
@@ -72,6 +73,9 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_HLWD=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_SSB_DEBUG=y
 CONFIG_FB=y
@@ -89,6 +93,10 @@ CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-- 
2.17.0
