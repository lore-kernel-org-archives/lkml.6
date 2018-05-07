Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AB8JxZpqYKUqB5LGe56GQpl96tMSxHO3yONk4hVhJ4pyOMNl1VG0Y+eZxkDetoBuFK2fllRYGxHE
ARC-Seal: i=1; a=rsa-sha256; t=1525702869; cv=none;
        d=google.com; s=arc-20160816;
        b=Ge7DDwILUfaPC63YgB78xGbrpx7KMML9GuRxmrsO0+tVtxlrFWLWKV/j5BAGJ/SPNA
         ItsUnONT+tS3YiB8rcM0Mj/yW8gPCupI9Zw/nr34BBJ7gepneQiL+YJaxrn1D26wGhGa
         nkrZ2fHo51ytlJAzVlZQ2ugnxweQjotYvnIZXKOW8UwTvESp+YrVCm94J4N4k3ehrEVm
         XMtWBt2EjoOfsh5lHcXNi4z162fvqbPLQPdOdW3N8rT/QRl7+ptf1RJnzBIPe5p8GOqa
         s5af4wKciSIH/QWWCT7lSIDfIx6wUKPxwIKsD91DNlHgfGvVPsBW76nEqnh/9A8OfF/A
         0UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Jd5FF0YdCktfW2u8TJdnI7y1iSCMm0lys0eMgu1cIbg=;
        b=bKms1/EYK+aaAw8AnMVcr+TpZkoz/OgAC6NFmeRCcHfigEtyc0PB/2TlHgJuaih346
         55wjiIFtNVQKk9uuhITFW629FFMeuhfnKvGZG3ksvQ34oP9eLhl9SjjucAm7vW6XlJJE
         wHiE2hvd1B0EsJAsT0I0Jxgoh8/Gr5rlqmRZGHD7Ft/F84I/BB20Z6brMOoLOBwmbLQT
         vWMuUz5CPeDZkVCuK0KmZ2KUrVreJYsMB6BHUgUDakrYkBEK6N3xIasi8sCwToOaL6ZG
         YgkJN/G2TWAjza4OA24OlblQqwzH32rvsxidPSOQ9///I8aU2bSn6ut1Dj4+nxs+r1ZZ
         1c+w==
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
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Benjamin Gilbert <benjamin.gilbert@coreos.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] powerpc: wii_defconfig: Enable GPIO-related options
Date: Mon,  7 May 2018 16:20:17 +0200
Message-Id: <20180507142019.32669-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+Bfb15xBEyTweXudWqGbXUPT3ZLoGf3FBzCFnM2W8o3rgwladhn
 VMH2cE2KX4o3Fq25oBAtya48E9efppc2327Hf4arSKu869+J96umHi7jT1sRbO+XrfB6v1N
 F4/zP+fKcGE06vewrjoFeJZKOA1FjpO/TkU9ywRY4rEb/6CSfrLqo3QKrZHzcrA0ac8AHC0
 JWTbo6ywDt/eBSkmJOQRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BQdhDDD7gHg=:SwdLW4Xa8PFJvXsSiXc2EH
 AOJGvEtn7dsTMro7aXtQ1HKMZIZTV+4dM24neHk2SNYFpq/fHPyXnPsRny1nAQSHNLa9hHrX4
 B9Oq9zYrjXxCdQedVEc/7oOq3FfD2UJxPbvZ1p1MDThxpCQZ5/t+KNzIZTrHkdrPREejiGSpw
 X8GXFcC0WXQIXWn1eUCog/ld8KWiSi4C5XDMHO/hxQXFSXXRUjVceu67HRHmQFf6R6JUqa8av
 WEm6XCZB48hFm6k2sJDvwNcyvd1PRF6UKKe62yKhNu0HSfgjikFTjXXeJFdkpmGtr8ld9b2wL
 MviU2kv4cn7QfqKLVOiev5JZJ3ZyrM3XkWuyoYT8DIwVsOS9v6cp7K430mE9fpYn42t54fA2F
 qf2JsxTy5w7AldaCg5ZVqDUJKWIgBsXndlh5M+4gqLCvHzYpp26+KEL047BK+O4s/5PIS593x
 53oT8XDKvhL12yHdVuXKXDTIf+YxTOjCYE/3P9R5Fsf3PoxyvB9IynLA+ttuDozEdKWskqqZy
 TmFtjCcJKhNNCKjY1FtiA8VMgtfHiaIU4LTVpQ9BPQI3PQDqhnfCzLAv2XYNzY1QVJEeAc7wk
 JEoOG0QJeYxqiPXbfzmXroT++OI5lc2LHflAGAGrR0gb061ONjREkHvXloJGyfyPgk2WNTq1U
 n2wKZlOM9CB00K7BtTaK8vE7JGii/L4jXQeVAoXVRE5xprgSYeYx3ouxLZ9p8G1eAPKGvD8LC
 INyZUU7LQ2hScN8IE3D8DqubnzgA9ri99FiemTaK1mk2g+haPAvdls+BqiKusUOaYlIYGQpHf
 yEDP+Zb
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599179228553644681?=
X-GMAIL-MSGID: =?utf-8?q?1599815412528365758?=
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
v2:
- Set CONFIG_NEW_LEDS=y and CONFIG_LEDS_TRIGGERS=y, without which some
  of the other options can't be set.
---
 arch/powerpc/configs/wii_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 3167b9d7f3e5..c5933a38e5ad 100644
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
@@ -89,6 +93,12 @@ CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-- 
2.17.0
