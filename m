Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x2268nBWaIKeG+W4vGNDuiRSKwAb/ytV67rsH7Th13+08ijbEKunplT5TdXLLj9A/epdmDam3
ARC-Seal: i=1; a=rsa-sha256; t=1519127961; cv=none;
        d=google.com; s=arc-20160816;
        b=ra21M/oup6nys4mXyu8p263/sc6bRKa1uIHyeyGD7fACSfu1hbE1uqrXN+IOKjXLVN
         pxIaZvAVxtxkGaIXr4IuBCZ3av5k1rEhCYxc/T321hhllm55U70QRpbrLytUa7sFtXNs
         XpfEFR3TiwdIy3Xwm1ZrFSw+yTnu8et8YhcPTh93tRrQzHDdOWYdzsBb7XWF6xH97sAv
         Ky4bXoPETrtSgq+acKZ9q1KdYE1+tO6impeSEVqTvcE0OW0kOfAo9U/KPotFuRCS40UP
         bnuC2U2r0Vhk40zZITWAkKUIMOv9pexIVnE5dHHj6cbpVuwCErUq4A1REkAQHW0ih/ZT
         4lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=lO1xwjw2ZFborsuj45l1IraIuw4lQoXCHOvHVM+TlcM=;
        b=Tzv2D3caiiPtwdJcFfnkLTgNzgKiGpoen99avRAeCyao5tZRBur1WlrT8zeC7OWCj2
         I+fseDa1NNGPXaLT6bZx3eRKh3JUjNxuKVCvhzZDmVuKpoLc2LA0Iv1Rq9Ifc8FSWTnv
         4gn/hZnsDbc7npqscfb6AlP55UjtMb37FUdelG/fCp3rvHYCW/HV/zJYS0SyleK04WzQ
         vsqe3XqSVpbDPZYR9CAa1aNprfKpKaAF21f484H63aw9Hn4EnnHchUbfW8MiaWEzxlLt
         bxOeCp5x6PdC/BWojDnUIhFPKbjZ21lqdSNV46TLAUnVNkXMHq+PglsCgoQRE5F/+eto
         FdmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Darren Hart <dvhart@linux.intel.com>,
	Darren Hart <dvhart@infradead.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: [4.4-stable 13/22] dell-wmi, dell-laptop: depends DMI
Date: Tue, 20 Feb 2018 12:55:00 +0100
Message-Id: <20180220115527.1806578-14-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:b5Ut8s2T8htKC4DXQSbr4hpszt1ZXSQvKIVA6tcYtKDA/JQ9Otp
 naErxc9sDT6bL5rjg9J7T9P8xpcg1cKZLY/o07MojvyLatHOrVPnXPp0ENmXnbs1quDfrX2
 daOR9TvLHyl6xii8m/qvA8Q+ACgFZo3VkYSg/eyLL41dm+IbU65LVhFXbhnrkU4BQ7Lqwyf
 NH28GlcqFYjXTyaghMINA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QuHlbSaF4B4=:e78zY1H+b9WnLcOJNUbvTm
 vv1J2ZfZxFvrduvO6WkDplhZjYKT8NmMQRR9Ir90T6CT5rtVDJjnz8tzsSN7yHu0jx849LVMP
 WYjGhw86oil/NC0oHGH14U55XLNbiCdvHZiI3rDfy/7XENnvBEGR/1cNHG0eovDGdqpho3yPW
 fRTUHEYabnk5GQqOPRW8cHzzKxFI+K4qjSIedP3LTeoutIjlYHsFKffDMj7iIYckGTBiysLcN
 5OcT4+C4g7z5X8NyA0MRj0mCYBBaRu3GxVpXQXjEIwF04rtqlFWbI3NaYEfmt5UaNZZGRjAMj
 uCELyCvhWw6V2GcCFBBSUaugbCQv8AyNDASZiPAi+hSxds1vyXDdkXkzM9gWAvF5k7mr/hiJo
 6/AG3Z73fXsBjPJWr/lqpPQ8xZ5Dt6A7H2xksA/gHXT2J9LXboooDdPYnhRnwL+C2gmUmq3IO
 TGsg4pTZRWQat7UCo26WYM1UK03bS4VDXWUo//JK3II6Th0/sd/bZX8s2eSaDrXPFVA0ikCDl
 4Qb9gaiW0I87XOr8abmYn5viExEgv99nY2z8suarkhvW41dizoE64dju2JJtLR4H1KTxpQ0LD
 N1/TVCB/zzgzP9xqkpLSosNH0HnFY+89SkwaEgYpqKKwOXlB1RyVIO2o8lDuAWitmfXP5j1ky
 dpXBg9dBh+1IHmMDXdpuHwxTO5R7s1B9R9qHabvZfb206ND/nLyRnIMNuc8xEn/7mc1C7zlC0
 8tMxVtEC5Uo2EkZ/7FqnuQw5qujiLzlTweePLt8YPNnbg/54gctHfmU5nzg=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921121952735562?=
X-GMAIL-MSGID: =?utf-8?q?1592921121952735562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit a570af4850043260b87fb1b8aa27a4484e648878 upstream.

dell-wmi and dell-laptop will compile but won't work right if DMI
isn't selected.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
[arnd: Use depends instead of selects to avoid recursive dependencies]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
[arnd: rebase to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1089eaa02b00..988ebe9a6b90 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -95,6 +95,7 @@ config DELL_LAPTOP
 	tristate "Dell Laptop Extras"
 	depends on X86
 	depends on DCDBAS
+	depends on DMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
@@ -110,6 +111,7 @@ config DELL_LAPTOP
 config DELL_WMI
 	tristate "Dell WMI extras"
 	depends on ACPI_WMI
+	depends on DMI
 	depends on INPUT
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
-- 
2.9.0
